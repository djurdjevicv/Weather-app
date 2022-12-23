//
//  SearchController.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import UIKit
import Resolver

class SearchViewController: UIViewController {

    @Injected var weatherNetworkingService: WeatherNetworkingService
    
    private let searchView = SearchView()
    private let disabledInternet = InternetDisabledView()
    private var cityList: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.searchView.resultsTableView.delegate = self
        self.searchView.resultsTableView.dataSource = self
        self.searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        disabledKeyboard()
    }
    
    
    func disabledKeyboard() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        searchView.searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
        
        if !Reachability.isConnectedToNetwork() {
            view = disabledInternet
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
            disabledInternet.actionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSettings)))
        } else {
            view = searchView
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        if let test = textField.text {
            if test.count > 0 {
                weatherNetworkingService.getLocation(cityName: test, limit: 5) { [self] result in
                    switch result {
                    case .success(let city):
                        cityList = city
                        DispatchQueue.main.async {
                            self.searchView.resultsTableView.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
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


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityList.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.resultsTableViewCell, for: indexPath) as? ResultsTableViewCell {
            if !cityList.isEmpty {
                let oneCity = cityList[indexPath.section]
                cell.cityLabel.text = oneCity.name
                cell.stateLabel.text = oneCity.country
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let lat = cityList[indexPath.section].lat
        let lon = cityList[indexPath.section].lon
        let city = cityList[indexPath.section].name
        let country = cityList[indexPath.section].country
        let detailsViewController = DetailsViewController()
        detailsViewController.lon = lon
        detailsViewController.lat = lat
        detailsViewController.city = city
        detailsViewController.country = country

        navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 20
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}


