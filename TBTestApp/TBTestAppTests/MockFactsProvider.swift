//
//  MockFactsProvider.swift
//  TBTestAppTests
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import XCTest

@testable import TBTestApp

class MockSuccessFactsProvider: FactsProviding {

    func fetchFactsData(callback: @escaping (FactsData?, FactsError?) -> Void) {
        let data = FactsData(title: "About Canada", rows: [
            Fact(
                title: "Fact title1",
                description: "Fact description1",
                imageHref: "http://image1url.com"),
            Fact(
                title: "Fact title2",
                description: "Fact description2",
                imageHref: "http://image2url.com")
            ])
        callback(data, nil)
    }
}

class MockNetworkErrorFactsProvider: FactsProviding {

    func fetchFactsData(callback: @escaping (FactsData?, FactsError?) -> Void) {
        callback(nil, FactsError.networkUnavailable)
    }
}

class MockServerErrorFactsProvider: FactsProviding {

    func fetchFactsData(callback: @escaping (FactsData?, FactsError?) -> Void) {
        callback(nil, FactsError.serverError(statusCode: 500))
    }
}

class MockGenericErrorFactsProvider: FactsProviding {

    func fetchFactsData(callback: @escaping (FactsData?, FactsError?) -> Void) {
        callback(nil, FactsError.genericError)
    }
}
