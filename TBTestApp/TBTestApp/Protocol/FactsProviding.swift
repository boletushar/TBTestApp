//
//  FactsProviding.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

protocol FactsProviding {
    
    /// Function to fetch the Facts data
    /// - Parameter callback: callback holds FactsData and/or Error
    func fetchFactsData(
        callback:@escaping (_ result: FactsData?, _ error : Error?) -> ())
}

