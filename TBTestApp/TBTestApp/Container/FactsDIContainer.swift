//
//  FactsDIContainer.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation
import Swinject

class FactsDIContainer {

    func registerClasses(with container: Container) {

        // Register the Network provider class for Dependency Injection
        container.register(FactsProviding.self) {
            (resolver) -> FactsProviding in
            FactsProviderService()
        }

        // Register the Presenter controller class for Dependency Injection
        container.register(FactsPresenting.self) {
            (resolver, display) -> FactsPresenting in
            FactsPresenter(
                display: display,
                factsProvider: resolver.resolve(FactsProviding.self)!)
        }.inObjectScope(.weak)

        // Register the View controller class for Dependency Injection
        container.register(FactsDisplaying.self) {
            (resolver) -> FactsDisplaying in
            let viewController = FactsTableViewController()
            viewController.presenter = resolver.resolve(
                FactsPresenting.self,
                argument: viewController as FactsDisplaying)
            return viewController
        }.inObjectScope(.container)
    }
}
