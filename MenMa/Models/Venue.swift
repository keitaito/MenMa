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
    let latitude: Double
    let longitude: Double
    let distance: Int
    
    //    let location
    //    let menu
    //    let contact
    
    /// Designated Initializer.
    init(name: String, id: String, url: String?, latitude: Double, longitude: Double, distance: Int) {
        self.name = name
        self.id = id
        self.url = url
        self.latitude = latitude
        self.longitude = longitude
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
        guard let unarchivedLatitude = aDecoder.decodeObjectForKey("latitude") as? Double else { return nil }
        guard let unarchivedLongitude = aDecoder.decodeObjectForKey("longitude") as? Double else { return nil }
        guard let unarchivedDistance = aDecoder.decodeObjectForKey("distance") as? Int else { return nil }
        // Calle designated initializer.
        self.init(name: unarchivedName, id: unarchivedId, url: unarchivedUrl, latitude: unarchivedLatitude, longitude: unarchivedLongitude, distance: unarchivedDistance)
    }
    /// Required method for NSCoding Protocol.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(url, forKey: "url")
        aCoder.encodeObject(latitude, forKey: "latitude")
        aCoder.encodeObject(longitude, forKey: "longitude")
        aCoder.encodeObject(distance, forKey: "distance")
    }
}
