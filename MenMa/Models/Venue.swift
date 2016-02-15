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
    
    //    let location
    //    let menu
    //    let contact
    
    /// Designated Initializer.
    init(name: String, id: String, url: String?) {
        self.name = name
        self.id = id
        self.url = url
        
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // name and id should be non-nil value.
        guard let unarchivedName = aDecoder.decodeObjectForKey("name") as? String,
              let unarchivedId = aDecoder.decodeObjectForKey("id") as? String
            else { return nil }
        // url could be nil.
        let unarchivedUrl = aDecoder.decodeObjectForKey("url") as? String
        // Calle designated initializer.
        self.init(name: unarchivedName, id: unarchivedId, url: unarchivedUrl)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(url, forKey: "url")
    }
}
