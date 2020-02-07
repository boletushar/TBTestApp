//
//  FactsProviderService.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation

/// FactsError defining different type while fetching Facts from API
enum FactsError: Error {
    case networkUnavailable
    case serverError(statusCode: Int)
    case parsingError
}

class FactsProviderService: FactsProviding {

    private let factsAPI =
        "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    // Function to fetch facts data
    func fetchFactsData(
        callback:@escaping (_ result: FactsData?, _ error : Error?) -> ()) {
        
        guard let url = URL(string: factsAPI) else {
            callback(nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                callback(nil, FactsError.networkUnavailable)
                return
            }
            
            if 200...299 ~= statusCode {
                
                guard let dataResponse = data, error == nil else {
                    callback(nil, nil)
                    return
                }
                    
                let string = String(decoding: dataResponse, as: UTF8.self)
                guard let encodedData = string.data(using: .utf8) else {
                    callback(nil, FactsError.parsingError)
                    return
                }
               
                guard let result = try? JSONDecoder().decode(
                    FactsData.self,
                    from: encodedData)
                else {
                    callback(nil, FactsError.parsingError)
                    return
                }
                
                callback(result, nil)
                
            } else {
                callback(nil, FactsError.serverError(statusCode: statusCode))
            }
        }.resume()
    }
}

