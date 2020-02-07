//
//  TBTestAppTests.swift
//  TBTestAppTests
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import XCTest
import Swinject
@testable import TBTestApp

class TBTestAppTests: XCTestCase {
    
    var presenter: FactsPresenting?
    var mockDisplay: MockFactsDisplay!
    
    let container = Container()

    override func setUp() {
        // Put setup code here. This method is called before the
        // invocation of each test method in the class.
        super.setUp()
        
        mockDisplay = MockFactsDisplay()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the
        // invocation of each test method in the class.
        presenter = nil
        mockDisplay = nil
    }
    
    func mockRegistration() {
        
        container.register(FactsProviding.self) { (resolver) -> FactsProviderService in
            FactsProviderService()
        }
        
        container.register(FactsPresenting.self) { (resolver, display) -> FactsPresenter in
            FactsPresenter(
                display: display,
                factsProvider: resolver.resolve(FactsProviding.self)!)
        }.inObjectScope(.weak)
        
        container.register(FactsDisplaying.self) { (resolver) -> FactsDisplaying in
            let viewController = FactsTableViewController()
            viewController.presenter = resolver.resolve(
                FactsPresenting.self,
                argument: viewController as FactsDisplaying)
            return viewController
        }.inObjectScope(.container)
    }

    func testDependencyInjection() {
        
        mockRegistration()
        
        let viewController = container.resolve(FactsDisplaying.self) as? FactsTableViewController
        XCTAssertTrue(viewController != nil, "Viewcontroller Dependency injection failed")
        XCTAssertTrue(viewController?.presenter != nil,
                      "Viewcontroller unable to initiate presenter")
        
        let factsProvider = container.resolve(FactsProviding.self)
        XCTAssertTrue(factsProvider != nil, "")
    }
    
    func testAPI_Success() {
        let expectation = self.expectation(
            description: "Testing API returns the title field in the response")
        mockDisplay.expectation = expectation
        
        presenter = FactsPresenter(
            display: mockDisplay,
            factsProvider: MockSuccessFactsProvider())
        presenter?.viewDidBecomeVisible()
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(mockDisplay.title,
                       "About Canada",
                       "Unexpected title returned")
        XCTAssertTrue(!mockDisplay.facts.isEmpty, "Response returned no facts")
        XCTAssertTrue(mockDisplay.errorMessage.isEmpty,
                      "Unexpected error message returned")
    }
    
    func testAPI_NetworkFailure() {
        let expectation = self.expectation(
            description: "Testing when API fails")
        mockDisplay.expectation = expectation
        
        presenter = FactsPresenter(
            display: mockDisplay,
            factsProvider: MockNetworkErrorFactsProvider())
        presenter?.viewDidBecomeVisible()
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(
            mockDisplay.title.isEmpty,
            "Unexpected title not empty string")
        XCTAssertTrue(
            mockDisplay.facts.isEmpty,
            "Unexpected facts not empty array")
        XCTAssertEqual(
            mockDisplay.errorMessage,
            "It appears you are not connected to internet. Please connect to internet and retry.")
    }
    
    func testAPI_ServerError() {
        
        let expectation = self.expectation(
            description: "Testing API returns the facts field in the response")
        mockDisplay.expectation = expectation
        
        presenter = FactsPresenter(
            display: mockDisplay,
            factsProvider: MockServerErrorFactsProvider())
        presenter?.viewDidBecomeVisible()
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(
            mockDisplay.title.isEmpty,
            "Unexpected title not empty string")
        XCTAssertTrue(
            mockDisplay.facts.isEmpty,
            "Unexpected facts not empty array")
        XCTAssertEqual(
            mockDisplay.errorMessage,
            "Oops we have hit a snag. Retry after sometime.")
    }
    
    func testAPI_GenericError() {
        
        let expectation = self.expectation(
            description: "Testing API returns the facts field in the response")
        mockDisplay.expectation = expectation
        
        presenter = FactsPresenter(
            display: mockDisplay,
            factsProvider: MockGenericErrorFactsProvider())
        presenter?.viewDidBecomeVisible()
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(
            mockDisplay.title.isEmpty,
            "Unexpected title not empty string")
        XCTAssertTrue(
            mockDisplay.facts.isEmpty,
            "Unexpected facts not empty array")
        XCTAssertEqual(
            mockDisplay.errorMessage,
            "Something went wrong. Retry after sometime.")
    }
}
