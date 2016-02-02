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
    
    func download(url url: URLStringConvertible, parameters: [String : AnyObject]?, completion: (results: Array<Venue>) -> Void) -> Void {
        manager.request(.GET, url, parameters: parameters).responseJSON { (response: (Response<AnyObject, NSError>)) -> Void in
            if let results = Venue.parse(response) {
                completion(results: results)
            }
        }
    }
    
    func download(url url: URLStringConvertible, completion: (results: Array<Venue>) -> Void) -> Void {
        manager.request(.GET, url).responseJSON { response in
            if let results = Venue.parse(response) {
                completion(results: results)
            }
        }
    }
}

extension Venue {
    static func parse(response: (Response<AnyObject, NSError>)) -> [Venue]? {
        
        var resultsArray: [Venue] = [Venue]()
        
        // Parse JSON data.
        let responseResultValue: Dictionary? = response.result.value as? Dictionary<String, AnyObject>
        if let responseDictionary = responseResultValue?["response"] as? Dictionary<String, AnyObject> {
            if let venues = responseDictionary["venues"] as? Array<AnyObject> {
                print("Venus count: \(venues.count)")
                
                // Iterate venues array of JSON data.
                for venue in venues {
                    if let venue = venue as? Dictionary<String, AnyObject> {
                        guard let name = venue["name"] as? String else { return nil }
                        guard let id = venue["id"] as? String else { return nil}
                        let url = venue["url"] as? String
                        
                        // Instantiate objects of type Venue struct.
                        let aVenueStruct = Venue(name: name, id: id, url: url)
                        resultsArray.append(aVenueStruct)
                    }
                }
                return resultsArray
            }
        }
        return nil
    }
}
