//
//  APIRequestManager.swift
//  UMDBusMap
//
//  Created by Kristine Otto on 12/26/18.
//  Copyright © 2018 Kristine Otto. All rights reserved.
//

import UIKit

class APIRequestManager {
    static let sharedInstance = APIRequestManager()
    
    let session = URLSession.shared
    
    func MakeAPICall(url: URL, completion: @escaping () -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if error == nil {
                self.parseData(data: data!,completion: completion)
                //print(String(data: data!, encoding: .utf8))
            }
            else {
                print ("there was an error making api call: \(String(describing: error?.localizedDescription))")
            }
        }
        task.resume()
    }
    
    func parseData(data: Data, completion: @escaping () -> Void) {
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
        if let routesDictionary = dictionary?["route"] as? [[String: Any]] {
            //print(routesDictionary)
            for route in routesDictionary {
                if let stopsDictionary = route["stop"] as? [[String: String]] {
                   //parseRoute(route: route, stopsDictionary: stopsDictionary)
                }
                else {
                    let tag = route["tag"] as! String
                    MakeAPICall(url: URL(string: NextBusAPICalls.getRouteConfig(routeTag: tag))!, completion: {})
                }
            }
        }
        else if let routesDictionary = dictionary?["route"] as? [String: Any] {
            parseRoute(route: routesDictionary)
        }
        
    }
    
    func parseRoute(route: [String:Any]/*, stopsDictionary: [[String:String]]*/) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let title = route["title"] as! String
        let shortTitle = route["shortTitle"] as? String
        let lonMax = route["lonMax"] as! String
        let lonMin = route["lonMin"] as! String
        let latMax = route["latMax"] as! String
        let latMin = route["latMin"] as! String
        let color = route["color"] as! String
        let tag = route["tag"] as! String
            let stopsDictionary = route["stop"] as! [[String:String]]
            var stopObjDictionary = [Stops]()
            for stop in stopsDictionary {
                let stopObj = Stops(context: context!)
                stopObj.lon = stop["lon"]
                stopObj.lat = stop["lat"]
                stopObj.title = stop["title"]
                stopObj.shortTitle = stop["shortTitle"]
                stopObj.stopId = stop["stopId"]
                stopObj.tag = stop["tag"]
                stopObjDictionary.append(stopObj)
        }
        NextBusCoreDataManager.insertRoute(title: title, color: color, tag: tag, lonMax: lonMax, lonMin: lonMin, latMax: latMax, latMin: latMin, shortTitle: shortTitle, stopsDictionary: stopObjDictionary)
    }
    
}

