//
//  MainViewController.swift
//  MenMa
//
//  Created by Keita Ito on 1/16/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import UIKit
import Alamofire
import WatchConnectivity

class MainViewController: UIViewController, WCSessionDelegate {
    
    let url: URLStringConvertible = "https://api.foursquare.com/v2/venues/search?ll=37.7992426,-122.4007343&query=ramen&oauth_token=REZLGOWAE45WNZ21NHBSNUBNOJXC32AQYNFJOQEB0SLDPTQP&v=20150613"
    let manager = NetworkManager()
    
    var venues: Array<Venue> = Array<Venue>() {
        didSet {
            print(self.venues)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        manager.download(url: self.url) { (results) -> Void in
            self.venues = results
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
