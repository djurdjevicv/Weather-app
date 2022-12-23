//
//  SearchView.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import UIKit

class SearchView: UIView {
    
    lazy var searchTextField: UITextField = {
        let view = TextFieldWithPadding()
        view.accessibilityIdentifier = "edit_text_password"
        view.leftView = searchLeftView
        view.leftViewMode = .always
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.attributedPlaceholder = NSAttributedString(string: "Search location", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchTextFieldIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "searchIcon")
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var resultsLabel: UILabel = {
        var view = UILabel()
        view.text = "Results"
        view.font = UIFont.boldSystemFont(ofSize: 14.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var resultsTableView:  UITableView = {
        var view = UITableView()
        view.register(ResultsTableViewCell.self, forCellReuseIdentifier: Constants.resultsTableViewCell)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setBackgroundGradient()
    }
    
    private func setupView() {
        
        
        addSubview(searchTextField)
        searchTextField.addSubview(searchLeftView)
        searchLeftView.addSubview(searchTextFieldIcon)
        addSubview(resultsLabel)
        addSubview(resultsTableView)
        
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        
        searchLeftView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: 10).isActive = true
        searchLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        searchLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchLeftView.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
        
        searchTextFieldIcon.leadingAnchor.constraint(equalTo: searchLeftView.leadingAnchor, constant: 15).isActive = true
        searchTextFieldIcon.trailingAnchor.constraint(equalTo: searchLeftView.trailingAnchor, constant: -15).isActive = true
        searchTextFieldIcon.topAnchor.constraint(equalTo: searchLeftView.topAnchor, constant: 15).isActive = true
        searchTextFieldIcon.bottomAnchor.constraint(equalTo: searchLeftView.bottomAnchor, constant: -15).isActive = true
        
        resultsLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        resultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        resultsLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        resultsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
                        
        resultsTableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 5).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        
    }
    
    private func styleView() {
        searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        searchTextField.layer.cornerRadius = 50/2
        searchTextField.textColor = .white
        
        resultsLabel.textColor = .white
        
        resultsTableView.backgroundColor = .clear
        resultsTableView.separatorStyle = .none
        resultsTableView.insetsContentViewsToSafeArea = false

    }

}
