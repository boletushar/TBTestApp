//
//  Fact.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation

struct Fact: Codable {
    
    /// String holds the Fact title can be optional
    let title: String?
    
    /// String holds the Fact description can be optional
    let description: String?
    
    /// String holds the Fact image url can be optional
    let imageHref: String?
}
