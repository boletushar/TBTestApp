//
//  FactsData.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation

struct FactsData: Codable {

    /// String title used to show screen title
    let title: String

    /// Array of Fact which will be listed on screen
    let rows: [Fact]
}
