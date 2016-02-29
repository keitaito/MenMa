//
//  Venue.swift
//  MenMa
//
//  Created by Keita Ito on 1/30/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import UIKit
import Alamofire

class Venue: NSObject, NSCoding  {
    let name: String
    let id: String
    let url: String?
    let location: Dictionary<String, AnyObject>
    let distance: Int
    
    //    let location
    //    let menu
    //    let contact
    
    /// Designated Initializer.
    init(name: String, id: String, url: String?, location: Dictionary<String, AnyObject>, distance: Int) {
        self.name = name
        self.id = id
        self.url = url
        self.location = location
        self.distance = distance
        
        super.init()
    }
    
    /// Required method for NSCoding Protocol.
    required convenience init?(coder aDecoder: NSCoder) {
        // name and id should be non-nil value.
        guard let unarchivedName = aDecoder.decodeObjectForKey("name") as? String,
              let unarchivedId = aDecoder.decodeObjectForKey("id") as? String
            else { return nil }
        // url could be nil.
        let unarchivedUrl = aDecoder.decodeObjectForKey("url") as? String
        let unarchivedLocation = aDecoder.decodeObjectForKey("location") as! Dictionary<String, AnyObject>
        let unarchivedDistance = aDecoder.decodeObjectForKey("distance") as! Int
        // Calle designated initializer.
        self.init(name: unarchivedName, id: unarchivedId, url: unarchivedUrl, location: unarchivedLocation, distance: unarchivedDistance)
    }
    /// Required method for NSCoding Protocol.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(url, forKey: "url")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(distance, forKey: "distance")
    }
}
