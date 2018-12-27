//
//  NextBusCoreDataManager.swift
//  UMDBusMap
//
//  Created by Kristine Otto on 12/26/18.
//  Copyright © 2018 Kristine Otto. All rights reserved.
//

import UIKit
import CoreData

class NextBusCoreDataManager {
    static let sharedInstance = NextBusCoreDataManager()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static func insertRoute(title:String, color: String, tag: String, lonMax: String, lonMin: String, latMax: String, latMin: String, shortTitle: String?, stopsDictionary: [Stops]) {
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Routes", in: context) else {return}
        let newRoute = NSManagedObject(entity: entity, insertInto: context) as! Routes
        newRoute.color = color
        newRoute.title = title
        newRoute.tag = tag
        newRoute.lonMax = lonMax
        newRoute.lonMin = lonMin
        newRoute.latMax = latMax
        newRoute.latMin = latMin
        newRoute.shortTitle = shortTitle ?? ""
        
        for stop in stopsDictionary {
            stop.fromRoute = newRoute
        }
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print("There was an error saving the route. Error: \(error.localizedDescription)")
            return
        }
    }
    
    static func insertStop(title: String, stopId: String, tag: String, lat: String, lon: String, shortTitle: String?, route: Routes) -> Stops? {
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Stops", in: context) else {return nil}
        let newStop = NSManagedObject(entity: entity, insertInto: context) as! Stops
        newStop.lat = lat
        newStop.lon = lon
        newStop.stopId = stopId
        newStop.shortTitle = shortTitle ?? ""
        newStop.title = title
        newStop.tag = tag
        newStop.fromRoute = route
        
        do {
            try context.save()
            return newStop
        }
        catch let error as NSError {
            print("There was an error saving the stop. Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func getStops() -> [Stops] {
        let context = appDelegate.persistentContainer.viewContext
        var stops = [Stops]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stops")
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                stops.append(result as! Stops)
            }
        }
        catch let error as NSError {
            print("Could not fetch stops. Error: \(error.localizedDescription)")
        }
            return stops
    }
}

