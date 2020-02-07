//
//  NetworkManager.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager: NSObject {

   var reachability: Reachability!

   // Create a singleton instance
   static let sharedInstance: NetworkManager = { return NetworkManager() }()

   override init() {
       super.init()

       // Initialise reachability
       reachability = try? Reachability()

       // Register an observer for the network status
       NotificationCenter.default.addObserver(
           self,
           selector: #selector(networkStatusChanged(_:)),
           name: .reachabilityChanged,
           object: reachability
       )

       do {
           // Start the network status notifier
           try reachability.startNotifier()
       } catch {
           print("Unable to start notifier")
       }
   }

   @objc func networkStatusChanged(_ notification: Notification) {
       // Do something globally here!
   }

   static func stopNotifier() {
       // Stop the network status notifier
       NetworkManager.sharedInstance.reachability.stopNotifier()
   }

   // Network is reachable
   static func isReachable(completed: @escaping (NetworkManager) -> Void) {
       if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
           completed(NetworkManager.sharedInstance)
       }
   }

   // Network is unreachable
   static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
       if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
           completed(NetworkManager.sharedInstance)
       }
   }
}
