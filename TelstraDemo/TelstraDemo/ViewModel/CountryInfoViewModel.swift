//
//  CountryInfoViewModel.swift
//  TelstraDemo
//
//  Created by Pritesh on 25/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class CountryInfoViewModel: NSObject {
    
     // MARK: - Declared Property
    var networkManager = NetworkManager()
    var countryData : [CountryInfoModel]?
    
    // MARK: - Supporting functions
    func fetchDataFromNetworkLayer(completion: @escaping ()->()) {
        networkManager.getAllServiceData { (countryData, error) in
            self.countryData = countryData
            completion()
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return self.countryData?.count ?? 0
    }
    
    func configureCell(cell: CustomeTableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let title = self.countryData?[indexPath.row].title {
            cell.titleLabel.text = title
        }
        
        if let description = self.countryData?[indexPath.row].description {
            cell.descriptionLabel.text = description
        }
        
        cell.imageIconView.image = UIImage.init(named: CustomeTableViewCell.defaultImageName)
        cell.imageIconView.downloaded(from: self.countryData?[indexPath.row].imageHref ?? "", loader: cell.activityIndicatorView)
    }
    
    
}
