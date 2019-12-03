//
//  NetworkManager.swift
//  TelstraDemo
//
//  Created by Pritesh on 25/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

// MARK: Error Handling
enum CustomError: String {
    case errorParsingJSON = "Parsing error occured"
    case noInternetConnection = "Please check internet connection"
    case dataReturnedNil = "Something went wrong while fething data"
    case returnedError = "Error while fetching data"
    case invalidStatusCode =  "Invalid status code"
    case mimeType = "Wrong MIME Type"
    case invalidJsonFormat = "Invalid json format"
}


class NetworkManager: NSObject,NetworkManagerProtocol {
    
    // MARK: - Declared Property
    var rows:[CountryInfoModel]? = []
    
    // MARK: - Network Call
    func getAllServiceData(completion: @escaping([CountryInfoModel]?,String, String?) -> ()) {
        
        let urlString = GetURL.urlString
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil,"",CustomError.errorParsingJSON.rawValue)
            }else {
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completion(nil,"",CustomError.invalidStatusCode.rawValue)
                    return
                }
                
                guard let mime = response.mimeType, mime == "text/plain" else {
                    completion(nil,"",CustomError.mimeType.rawValue)
                    return
                }
                self.rows = [CountryInfoModel]()
                guard let data = data else {
                    completion(nil,"",CustomError.errorParsingJSON.rawValue)
                    return
                }
                let jsonString  = String(decoding: data, as: UTF8.self)
                let jsonData = jsonString.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [String: Any]
                    {
                        guard let titleText = jsonArray["title"] as? String else {return}
                        
                        if let rows = jsonArray["rows"] as? [[String: Any]] {
                            for result in rows {
                                let row = CountryInfoModel()
                                row.title = result["title"] as? String ?? ""
                                row.description = result["description"] as? String ?? ""
                                row.imageHref = result["imageHref"] as? String ?? ""
                                self.rows?.append(row)
                            }
                            completion(self.rows,titleText,nil)
                        }
                    } else {
                        completion(nil,"",CustomError.invalidJsonFormat.rawValue)
                    }
                } catch let error as NSError {
                    completion(nil,"",CustomError.returnedError.rawValue)
                    print(error)
                }
            }
            }.resume()
    }
}
