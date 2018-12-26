//
//  APIRequestManager.swift
//  UMDBusMap
//
//  Created by Kristine Otto on 12/26/18.
//  Copyright © 2018 Kristine Otto. All rights reserved.
//

import Foundation

class APIRequestManager {
    static let sharedInstance = APIRequestManager()
    
    let session = URLSession.shared
    
    func MakeAPICall(url: URL, completion: @escaping () -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if error == nil {
                self.parseData(data: data!,completion: completion)
            }
            else {
                print ("there was an error making api call: \(String(describing: error?.localizedDescription))")
            }
        }
        task.resume()
    }
    
    func parseData(data: Data, completion: @escaping () -> Void) {
    }
}

