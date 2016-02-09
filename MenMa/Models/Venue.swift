//
//  Venue.swift
//  MenMa
//
//  Created by Keita Ito on 1/30/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import UIKit
import Alamofire

class Venue  {
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
