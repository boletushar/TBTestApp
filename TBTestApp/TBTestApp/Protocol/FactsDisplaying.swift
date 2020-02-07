//
//  FactsDisplaying.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

protocol FactsDisplaying: AnyObject {
    
    /// Ask display to set the display data
    /// - Parameter data: data of type FactsData received from API
    func setDisplayData(_ data: FactsData)
    
    /// Ask display to show error message
    /// - Parameter message: error message to be displayed
    func showErrorMessage(_ message: String)
}
