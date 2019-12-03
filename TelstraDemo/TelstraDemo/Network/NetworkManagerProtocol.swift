//
//  NetworkManagerProtocol.swift
//  TelstraDemo
//
//  Created by Pritesh on 27/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
protocol NetworkManagerProtocol {
    func getAllServiceData(completion: @escaping([CountryInfoModel]?,String,String?) -> ())
}

