//
//  SettingsController.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import UIKit
import Resolver
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import MapKit

class SettingsViewController: UIViewController {
    
    @Injected var databaseService: DatabaseService
    private let locationManager = CLLocationManager()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(SettingsLabelTableViewCell.self, forCellReuseIdentifier: Constants.settingLabelTableViewCell)
        table.register(SettingsSwitchTableViewCell.self, forCellReuseIdentifier: Constants.settingsSwitchTableViewCell)
        table.register(SettingsLabelDegreesTableViewCell.self, forCellReuseIdentifier: Constants.settingsLabelDegreesTableViewCell)
        return table
    }()
    
    private var models = [Section]()
    private let disabledInternet = InternetDisabledView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.setBackgroundGradient()
        hidesBottomBarWhenPushed = true
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
        if !Reachability.isConnectedToNetwork() {
            view = disabledInternet
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
            disabledInternet.actionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSettings)))
        } else {
            self.models = []
            self.configure()
            self.tableView.reloadData()
        }
    }
    
    func actionOnLogOut(){
        UserDefaults.selectedFavoriteLocation = nil
        UserDefaults.unitSystem = UnitSystem.celsius.rawValue
        UserDefaults.favoriteLocations = nil
        
        if UserDefaults.currentLocation != nil {
            UserDefaults.selectedFavoriteLocation = UserDefaults.currentLocation
        }
    }
    
    func configure(){
        var degrees: String = ""
        var locations: String = ""
        if UserDefaults.unitSystem == UnitSystem.fahrenheit.rawValue {
            degrees = "°F"
        } else {
            degrees = "°C"
        }
        
        if UserDefaults.currentLocation == nil {
            locations = "Off"
        } else {
            locations = "On"
        }
        
        models.append(Section(title: "",options: [
            .switchCell(model: SettingsSwitchOption(title: "Dark mode", isOn: UserDefaults.standard.bool(forKey: Constants.isOn))),
            
            .degreesCell(model: SettingsDegreesLabelOption(title: "Location", degrees: locations, handler: {
                self.actionChangeLocationMode()
            })),
            
            .degreesCell(model: SettingsDegreesLabelOption(title: "Show temperature in", degrees: degrees, handler: {
                self.actionChangeTemperatureScale()
            }))
            
        ]))
        if databaseService.isLoggedUser() == false {
            models.append(Section(title: "",options: [
                .labelCell(model: SettingsOption(title: "Sign in", handler: {
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                })),
                .labelCell(model: SettingsOption(title: "Create an account", handler: {
                    self.navigationController?.pushViewController(RegisterViewController(), animated: true)
                }))
            ]))
        } else {
            models.append(Section(title: "",options: [
                .labelCell(model: SettingsOption(title: "Log out", handler: {
                    self.databaseService.logout()
                    self.models = []
                    self.configure()
                    self.actionOnLogOut()
                    self.tableView.reloadData()
                }))
            ]))
        }
    }
    
    @objc func actionChangeTheme(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: Constants.isOn)
            UserDefaults.standard.set(true, forKey: Constants.choosenTheme)
            self.view.setBackgroundGradient()
        } else {
            UserDefaults.standard.set(false, forKey: Constants.isOn)
            UserDefaults.standard.set(false, forKey: Constants.choosenTheme)
            self.view.setBackgroundGradient()
        }
    }
    
    func actionChangeTemperatureScale(){
        let myActionSheet =  UIAlertController(title: "Select temperature scale?", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        myActionSheet.addAction(UIAlertAction(title: "Celsius - °C", style: UIAlertAction.Style.default, handler: { (ACTION :UIAlertAction!)in
            UserDefaults.unitSystem = UnitSystem.celsius.rawValue
            if self.databaseService.emailLoginUser() != "" {
                self.databaseService.updateUserUnitSystem(email: self.databaseService.emailLoginUser(), unitSystem: UnitSystem.celsius.rawValue)
            }
            self.models = []
            self.configure()
            self.tableView.reloadData()
        }))
        myActionSheet.addAction(UIAlertAction(title: "Fahrenheit - °F", style: UIAlertAction.Style.default, handler: { (ACTION :UIAlertAction!)in
            UserDefaults.unitSystem = UnitSystem.fahrenheit.rawValue
            if self.databaseService.emailLoginUser() != "" {
                self.databaseService.updateUserUnitSystem(email: self.databaseService.emailLoginUser(), unitSystem: UnitSystem.fahrenheit.rawValue)
            }
            self.models = []
            self.configure()
            self.tableView.reloadData()
        }))
        self.present(myActionSheet, animated: true, completion: nil)
    }
        
    func actionChangeLocationMode(){
        let locationActionSheet =  UIAlertController(title: "Turn on location?", message: nil, preferredStyle: .actionSheet)
        locationActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        locationActionSheet.addAction(UIAlertAction(title: "On", style: .default, handler: { _ in
            
        }))
        locationActionSheet.addAction(UIAlertAction(title: "Off", style: .destructive, handler: { _ in
            //UserDefaults.currentLocation = nil
        }))
        self.present(locationActionSheet, animated: true, completion: nil)
    }
    
    @objc private func openSettings() {
        guard let settingsUrl = URL(string: "App-Prefs:root=WIFI") else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self{
        case .labelCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.settingLabelTableViewCell, for: indexPath) as? SettingsLabelTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.settingsSwitchTableViewCell, for: indexPath) as? SettingsSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.mySwitch.addTarget(self, action: #selector(actionChangeTheme), for: .valueChanged)
            cell.configure(with: model)
            return cell
        case .degreesCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.settingsLabelDegreesTableViewCell, for: indexPath) as? SettingsLabelDegreesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self{
        case .labelCell(let model):
            model.handler()
        case .degreesCell(let model):
            model.handler()
        case .switchCell(_):
            print("click")
        }
        
    }
    
}

