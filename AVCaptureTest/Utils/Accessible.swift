//
//  Accessible.swift
//  TokyoSubways
//
//  Created by Tom Bluewater on 12/23/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation
import SystemConfiguration

class Accessible {
    static func isInternetAvailable() -> Bool {
        // http-//stackoverflow.com/questions/25623272/how-to-use-scnetworkreachability-in-swift/25623647#25623647
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let cellular = flags.contains(.isWWAN)
        let connected = (cellular || isReachable && !needsConnection) ? true : false
        
        return connected
    }
}

