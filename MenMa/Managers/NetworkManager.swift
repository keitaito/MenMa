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
            // If error is in reponse, print it out.
            if let error = response.result.error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let results = Venue.parse(response) {
                completion(results: results)
            } else {
                // If nil is returned, from parsing. print out.
                print("Parsing error: no results. network issue, or parsing issue.")
            }
        }
    }
    
    func download(url url: URLStringConvertible, completion: (results: Array<Venue>) -> Void) -> Void {
        manager.request(.GET, url).responseJSON { response in
            print(response)
            // If error is in reponse, print it out.
            if let error = response.result.error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let results = Venue.parse(response) {
                completion(results: results)
            } else {
                // If nil is returned, from parsing. print out.
                print("Parsing error: no results. network issue, or parsing issue.")
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
                print("Venues count: \(venues.count)")
                
                // Iterate venues array of JSON data.
                for venue in venues {
                    if let venue = venue as? Dictionary<String, AnyObject> {
                        guard let name = venue["name"] as? String else { return nil }
                        guard let id = venue["id"] as? String else { return nil }
                        let url = venue["url"] as? String
                        guard let location = venue["location"] as? Dictionary<String, AnyObject>,
                            let latitude = location["lat"] as? Double,
                            let longitude = location["lng"] as? Double,
                            let distance = location["distance"] as? Int
                            else { return nil }
                        
                        // Instantiate objects of type Venue struct.
                        let aVenueStruct = Venue(name: name, id: id, url: url, latitude: latitude, longitude: longitude, distance: distance)
                        resultsArray.append(aVenueStruct)
                    }
                }
                return resultsArray
            }
        }
        return nil
    }
}
