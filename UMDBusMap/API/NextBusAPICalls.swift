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
    
    let root = "http://webservices.nextbus.com/service/publicJSONFeed?a=umd"
    
    var routeList: String {
        return root + "&command=routeList&t=0"
    }
    
    var agencyList: String {
        return root + "&command=agencyList"
    }
    
    func getRouteConfig(routeTag: String) -> String {
        return root + "&command=routeConfig&r=\(routeTag)"
    }
    
    func getRoutePrediction(stopTag: String, routeTag: String) -> String {
        return root + "&command=predictions&s=\(stopTag)&r=\(routeTag)"
    }
    
    func getRouteSchedule(routeTag: String) -> String {
        return root + "&command=schedule&r=\(routeTag)"
    }
    
    func getRouteMessages(routeTag: String) -> String {
        return root + "&command=messages&r=\(routeTag)"
    }
    
    func getCurrentBusLocation(routeTag: String) {
        return root + "&command=vehicleLocation&r"
    }
    
    //if t=0 you get the data for the past 15 minutes of data collection
    //subsequent calls could save time by saving the time returned by the vehicle locations command
    
    //command to return all of the different routes and their tags
    //http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=routeList&t=0s
    
    //returns all of the different agencyLists
    //http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=agencyList
    
    //returns the latitude and logitude of the route stops
    //command=routeConfig
    
    //use the routeList to get the tag of the route and the routeConfig to get all of the stops within that route
    //routeConfig will give the stoptags of all stops along the route, this can be used in the prediciton call
    
    //get predictions using the route tag and the stop TAG with the predictions call
    //http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=predictions&s=stamsuhh_d&r=114
    
    //get route schedules using the schedule call and the route tag
    //http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=schedule&r=114
    
    //get messages associated with a route, this will let you know if it is out of order, etc.
    //http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=messages&r=114
    
    //get buses current location using route, id and epoch time
    //http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=vehicleLocations&r=114&t=1545855661
    
    //get Vehicle location using the vehicle ID
    //http://webservices.nextbus.com/service/publicXMLFeed?command=vehicleLocation&a=umd&v=<vehicle id>
}
