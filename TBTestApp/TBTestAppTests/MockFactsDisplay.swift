//
//  MockFactsDisplay.swift
//  TBTestAppTests
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import XCTest

@testable import TBTestApp

class MockFactsDisplay: FactsDisplaying {
    
    var expectation: XCTestExpectation?
    
    private(set) var title: String = ""
    private(set) var facts: [Fact] = []
    func setDisplayData(_ data: FactsData) {
        title = data.title
        facts = data.rows
        expectation?.fulfill()
    }
    
    private(set) var errorMessage: String = ""
    func showErrorMessage(_ message: String) {
        errorMessage = message
        expectation?.fulfill()
    }
}
