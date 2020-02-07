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
    
    let container = Container()

    override func setUp() {
        // Put setup code here. This method is called before the
        // invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the
        // invocation of each test method in the class.
        presenter = nil
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
}
