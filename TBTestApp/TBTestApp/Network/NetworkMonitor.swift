//
//  NetworkMonitor.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkMonitor {

    static func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else { return false }

        var flags = SCNetworkReachabilityFlags()
        guard SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) else { return false }

        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }

}
