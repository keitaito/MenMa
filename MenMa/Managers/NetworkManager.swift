//
//  NetworkManager.swift
//  MenMa
//
//  Created by Keita Ito on 1/16/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    let manager = Alamofire.Manager.sharedInstance
    
    func download(url url: URLStringConvertible, completion: (results: Array<Venue>) -> Void) -> Void {
        
        var resultsArray: Array<Venue> = Array<Venue>()
        
        manager.request(.GET, url).responseJSON { response in
            // Parse JSON data.
            let responseResultValue: Dictionary? = response.result.value as? Dictionary<String, AnyObject>
            if let responseDictionary = responseResultValue?["response"] as? Dictionary<String, AnyObject> {
                if let venues = responseDictionary["venues"] as? Array<AnyObject> {
                    print("Venus count: \(venues.count)")
                    
                    // Iterate venues array of JSON data.
                    for venue in venues {
                        if let venue = venue as? Dictionary<String, AnyObject> {
                            guard let name = venue["name"] as? String else { return }
                            guard let id = venue["id"] as? String else { return }
                            let url = venue["url"] as? String
                            
                            // Instantiate objects of type Venue struct.
                            let aVenueStruct = Venue(name: name, id: id, url: url)
                            resultsArray.append(aVenueStruct)
                        }
                    }
                    // Completion handler. Pass resultsArray to the caller object.
                    completion(results: resultsArray)
                }
            }
        }
    }
}

struct Venue: GeneratorType  {

    let name: String
    let id: String
    let url: URLStringConvertible?
//    let location
//    let menu
//    let contact
    
    init(name: String, id: String, url: String?) {
        self.name = name
        self.id = id
        self.url = url
    }
}