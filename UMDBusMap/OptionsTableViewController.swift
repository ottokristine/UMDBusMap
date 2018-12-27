//
//  ViewController.swift
//  UMDBusMap
//
//  Created by Kristine Otto on 12/26/18.
//  Copyright © 2018 Kristine Otto. All rights reserved.
//

import UIKit
import CoreData

class OptionsTableViewController: UITableViewController {
    var tableMode = "Stops"
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var context: NSManagedObjectContext?
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Routes> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Routes> = Routes.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "tag", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    fileprivate lazy var StopsfetchedResultsController: NSFetchedResultsController<Stops> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Stops> = Stops.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "tag", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        context = appDelegate?.persistentContainer.viewContext
        
        //APIRequestManager.sharedInstance.MakeAPICall(url: URL(string: NextBusAPICalls.routeList)!, completion: {})
        
        try! StopsfetchedResultsController.performFetch()
        //APIRequestManager.sharedInstance.req
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = fetchedResultsController.fetchedObjects else { return 0 }
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        let route = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = route.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reload()
    }
    
    func reload() {
        switch tableMode {
        case "Routes":
            try! fetchedResultsController.performFetch()
        default:
            try! StopsfetchedResultsController.performFetch()
        }
        tableView.reloadData()
    }

}

extension OptionsTableViewController: NSFetchedResultsControllerDelegate {
}

