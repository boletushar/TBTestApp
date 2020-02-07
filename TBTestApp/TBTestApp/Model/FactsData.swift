//
//  FactsData.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation

struct FactsData: Codable {
    
    let title: String
    let rows: [Fact]
}
