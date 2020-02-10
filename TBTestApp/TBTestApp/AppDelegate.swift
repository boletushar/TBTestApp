//
//  AppDelegate.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        // Register your classes with dependency injection container
        let container = Container()
        FactsDIContainer().registerClasses(with: container)

        // swiftlint:disable force_cast
        let viewController = container.resolve(FactsDisplaying.self) as! FactsTableViewController
        // swiftlint:enable force_cast
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

extension UIApplication {

    static func topViewController(
        base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}
