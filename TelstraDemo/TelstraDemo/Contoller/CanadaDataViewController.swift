//
//  CanadaDataViewController.swift
//  TelstraDemo
//
//  Created by Pritesh on 26/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class CanadaDataViewController: UIViewController {
    
    // MARK: - Declared Property
    var viewModel = CountryInfoViewModel()
    let dataTableView = UITableView()
    let defaultCellHeight = CGFloat(100)
    var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setUpNavigation()
        self.dataTableView.register(CustomeTableViewCell.self, forCellReuseIdentifier: CustomeTableViewCell.cellIdentifire)

        
        viewModel.fetchDataFromNetworkLayer {
            print("Success")
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        self.setupTableView()
        self.loader()
    }
   
    // MARK: - UI Set Up
   fileprivate func setupTableView() {
        
        self.dataTableView.dataSource = self
        self.dataTableView.delegate = self
        self.dataTableView.rowHeight = UITableView.automaticDimension
        self.dataTableView.estimatedRowHeight = defaultCellHeight
        self.view.addSubview(self.dataTableView)
        
        self.dataTableView.translatesAutoresizingMaskIntoConstraints = false
        self.dataTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        self.dataTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        self.dataTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        self.dataTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        self.dataTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.dataTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.dataTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.dataTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func loader() {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        self.activityIndicatorView = activityIndicatorView
        self.activityIndicatorView.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: 20, height: 20)
        activityIndicatorView.startAnimating()
        self.view.addSubview(activityIndicatorView)
    }
    
   fileprivate func setUpNavigation() {
        navigationItem.title = "About Canada"
        self.navigationController?.navigationBar.barTintColor = _ColorLiteralType(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:_ColorLiteralType(red: 1, green: 1, blue: 1, alpha: 1)]
    }
}

// MARK: - UITableViewDataSource
extension CanadaDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomeTableViewCell.cellIdentifire, for: indexPath) as! CustomeTableViewCell
        viewModel.configureCell(cell: cell, forRowAtIndexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

}

// MARK: - UITableViewDelegate
extension CanadaDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (viewModel.countryData?[indexPath.row].description.isEmpty)! || (viewModel.countryData?[indexPath.row].title.isEmpty)! || (viewModel.countryData?[indexPath.row].imageHref.isEmpty)!{
            return defaultCellHeight
        }
        return UITableView.automaticDimension
    }
}


