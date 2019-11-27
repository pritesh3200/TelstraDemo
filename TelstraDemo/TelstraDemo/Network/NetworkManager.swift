//
//  NetworkManager.swift
//  TelstraDemo
//
//  Created by Pritesh on 25/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class NetworkManager: NSObject,NetworkManagerProtocol {
    
    // MARK: - Declared Property
    var rows : [CountryInfoModel]? = []
    
     // MARK: - Network Call
    func getAllServiceData(completion: @escaping([CountryInfoModel]?, Error?) -> ()) {
        
         let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
         guard let url = URL(string: urlString) else { return }
        
         URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(nil,err)
                print("Loading data error : \(err.localizedDescription)")
            }else {
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                guard let mime = response.mimeType, mime == "text/plain" else {
                    print("Wrong MIME type!")
                    return
                }
                self.rows = [CountryInfoModel]()
                guard let data = data else { return }
                let jsonString  = String(decoding: data, as: UTF8.self)
                let jsonData = jsonString.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [String: Any]
                    {
                        if let rows = jsonArray["rows"] as? [[String: Any]] {
                            for result in rows {
                                let row = CountryInfoModel()
                               
                                   row.title = result["title"] as? String ?? ""
                                   row.description = result["description"] as? String ?? ""
                                   row.imageHref = result["imageHref"] as? String ?? ""
                             
                                self.rows?.append(row)
                            }
                            completion(self.rows,nil)
                        }
                    } else {
                            print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
}
