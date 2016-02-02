//
//  ViewController.swift
//  MenMa
//
//  Created by Keita Ito on 6/13/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url: NSURL?
    var cachedRamenNames: [String] = []
    let sharedDefaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.keitaito.MenMa")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = NSURL(string: "https://api.foursquare.com/v2/venues/search?ll=37.7992426,-122.4007343&query=ramen&oauth_token=REZLGOWAE45WNZ21NHBSNUBNOJXC32AQYNFJOQEB0SLDPTQP&v=20150613")
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let serializedJSON: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            
            let venueArray = serializedJSON["response"]!["venues"] as! NSArray
            
            for venue in venueArray {
                let name = venue["name"]
                if let n = name as? NSString {
                    print(n)
                    self.cachedRamenNames.append(n as String)
                }
            }
            
            self.sharedDefaults.setObject(self.cachedRamenNames, forKey: "ramenPlaceNames")
            self.sharedDefaults.synchronize()
            
            print(self.cachedRamenNames)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
