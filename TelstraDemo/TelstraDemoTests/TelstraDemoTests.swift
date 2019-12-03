//
//  TelstraDemoTests.swift
//  TelstraDemoTests
//
//  Created by Manikanth on 25/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import TelstraDemo

class TelstraDemoTests: XCTestCase {
    
    let networkManager = NetworkManager()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetServiceDataResult_CheckNil() {
        var serviceData : [CountryInfoModel]?
        networkManager.getAllServiceData {  (countryData,title,error) in
            serviceData = countryData
            XCTAssertNil(serviceData)
        }
    }
    
    func testGetServiceParameters_CheckIfAllTitleAreNotNil() {
        var serviceData : [CountryInfoModel]?
        networkManager.getAllServiceData { (countryData,title,error) in
            serviceData = countryData
            
            for result in serviceData ?? [] {
                XCTAssertNotNil(result.title)
                XCTAssertTrue(result.title.count > 0)
            }
        }
    }
    
    func testGetServiceParameters_CheckIfAllDescriptionAreNotNil() {
        var serviceData : [CountryInfoModel]?
         networkManager.getAllServiceData { (countryData,title,error) in
            serviceData = countryData
            
            for result in serviceData ?? [] {
                XCTAssertNotNil(result.description)
                XCTAssertTrue(result.description.count > 0)
            }
        }
    }
    
    func testGetServiceParameters_CheckIfTitleIsNil() {
        networkManager.getAllServiceData { (countryData,title,error) in
            XCTAssertNotNil(title)
            XCTAssertTrue(title.count > 0)
        }
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
