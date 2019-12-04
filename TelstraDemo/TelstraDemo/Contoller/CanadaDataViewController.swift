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
    let defaultCellHeight = CGFloat(80)
    var activityIndicatorView: UIActivityIndicatorView!
    var reachability: Reachability?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(CanadaDataViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.Blue.SkyBlue
        return refreshControl
    }()
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkInternetConection()
        self.view.backgroundColor = .white
        self.setUpNavigation()
        self.dataTableView.register(CustomeTableViewCell.self, forCellReuseIdentifier: CustomeTableViewCell.cellIdentifire)
        self.fetchServiceData()
        self.setupTableView()
        self.loader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        let xConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.dataTableView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self.dataTableView, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([xConstraint, yConstraint])
    }
    
    // MARK : Service Call
    fileprivate func fetchServiceData() {
        if ((self.reachability!.connection) != .unavailable) {
            viewModel.fetchDataFromNetworkLayer {[weak self] (title, error)  in
                if error == nil {
                    DispatchQueue.main.async {
                        self?.navigationItem.title = title
                        self?.dataTableView.reloadData()
                        self?.activityIndicatorView.stopAnimating()
                    }
                }else {
                    if let err = error {
                        DispatchQueue.main.async {
                            self?.activityIndicatorView.stopAnimating()
                        }
                        self?.presentAlert(withTitle: "Error", message: err)
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            self.presentAlert(withTitle: "Error", message: CustomError.noInternetConnection.rawValue)
        }
    }
    
    // MARK: - UI Set Up
    fileprivate func setupTableView() {
        
        self.dataTableView.dataSource = self
        self.dataTableView.delegate = self
        self.dataTableView.rowHeight = UITableView.automaticDimension
        self.dataTableView.estimatedRowHeight = defaultCellHeight
        self.view.addSubview(self.dataTableView)
        self.dataTableView.addSubview(self.refreshControl)
        
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
        activityIndicatorView.startAnimating()
        self.dataTableView.addSubview(activityIndicatorView)
    }
    
    fileprivate func setUpNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.Blue.SkyBlue
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.White.CustomWhite]
    }
    
    // MARK: Handle Pull To Refresh
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.fetchServiceData()
        self.dataTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: Check Internet Connection
    fileprivate func checkInternetConection() {
        do {
            self.reachability = try Reachability.init()
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
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
        return UITableView.automaticDimension
    }
}


