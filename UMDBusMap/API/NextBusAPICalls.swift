//
//  APICalls.swift
//  UMDBusMap
//
//  Created by Kristine Otto on 12/26/18.
//  Copyright © 2018 Kristine Otto. All rights reserved.
//

import Foundation

class NextBusAPICalls {
    static let sharedInstance = NextBusAPICalls()
    
    static let root = "http://webservices.nextbus.com/service/publicJSONFeed?a=umd"
    
    static var routeList: String {
        return root + "&command=routeList&t=0"
    }
    
    static var agencyList: String {
        return root + "&command=agencyList"
    }
    
    static func getRouteConfig(routeTag: String) -> String {
        return root + "&command=routeConfig&r=\(routeTag)"
    }
    
    static func getRoutePrediction(stopTag: String, routeTag: String) -> String {
        return root + "&command=predictions&s=\(stopTag)&r=\(routeTag)"
    }
    
    static func getRouteSchedule(routeTag: String) -> String {
        return root + "&command=schedule&r=\(routeTag)"
    }
    
    static func getRouteMessages(routeTag: String) -> String {
        return root + "&command=messages&r=\(routeTag)"
    }
    
    static func getCurrentBusLocation(routeTag: String) -> String {
        return root + "&command=vehicleLocation&r=\(routeTag)&t=0"
    }
    
    static func getCurrentBusLocation(vehicleID: String) -> String {
        return root + "&command=vehicleLocation&v=\(vehicleID)&t=0"
    }
    
}
