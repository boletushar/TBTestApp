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
    case genericError

    var localizedDescription: String {
        switch self {
        case .networkUnavailable:
            return NSLocalizedString("error.message.network", comment: "No internet connection")
        case .serverError(statusCode: _):
            return NSLocalizedString("error.message.server", comment: "Server error message")
        case .genericError,
             .parsingError:
            return NSLocalizedString("error.message.generic", comment: "Server error message")
        }
    }
}

class FactsProviderService: FactsProviding {

    // MARK: - Private variables

    private let factsAPI =
        "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    // Function to fetch facts data
    func fetchFactsData(
        callback:@escaping (_ result: FactsData?, _ error : FactsError?) -> ()) {

        guard NetworkMonitor.isConnectedToNetwork() else {
            callback(nil, FactsError.networkUnavailable)
            return
        }

        guard let url = URL(string: factsAPI) else {
            callback(nil, FactsError.genericError)
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
                    callback(nil, FactsError.serverError(statusCode: 0))
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
