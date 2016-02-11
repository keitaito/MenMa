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
import CoreLocation

@available(iOS 9.0, *) //only available for <iOS 9.0
class MainViewController: UIViewController, WCSessionDelegate, LocationManagerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var venuesLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    // MARK: - Properties
    
    var session: WCSession!
    
    let url: URLStringConvertible = "https://api.foursquare.com/v2/venues/search?ll=37.7992426,-122.4007343&query=ramen&oauth_token=REZLGOWAE45WNZ21NHBSNUBNOJXC32AQYNFJOQEB0SLDPTQP&v=20150613"
    let baseURL: URLStringConvertible = "https://api.foursquare.com/v2/venues/search"
    var parameters: [String: AnyObject]? = ["ll" : "", "query" : "ramen", "oauth_token" : "REZLGOWAE45WNZ21NHBSNUBNOJXC32AQYNFJOQEB0SLDPTQP&v=20150613"]
    
    let manager = NetworkManager()
    let locationManager = LocationManager()
    
    var venues: Array<Venue> = Array<Venue>() {
        didSet {
            venues.forEach {
                print("name: \($0.name)")
            }
        }
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self to locationManager's delegate.
        locationManager.delegate = self;

        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        // Do any additional setup after loading the view.
        manager.download(url: self.url) { (results) -> Void in
            var array: Array<Venue> = results 
            array = Array(array[0..<5])
            self.venues = array
            
//            self.venues = results
        }
        
        locationManager.startStandardUpdates()
    }
    
    @IBAction func didTapDownloadButton(sender: UIButton) {
        manager.download(url: url, parameters: parameters) { (results) -> Void in
            self.venues = results
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        //handle received message
        let value = message["value"] as? String
        dispatch_async(dispatch_get_main_queue()) {
            self.venuesLabel.text = value
        }
        
        //send a reply
        replyHandler(["value":self.venues])
        
    }
    
    // MARK: - LocationManagerDelegate
    
    func locationManagerDidReceiveLocation(location: CLLocation) {
//        print("latitude: \(location.coordinate.latitude), longitude \(location.coordinate.longitude)\n")
        self.latitudeLabel.text = String(location.coordinate.latitude)
        self.longitudeLabel.text = String(location.coordinate.longitude)
        
        let llString: String = locationManager.urlParameter(location: location)
        parameters?.updateValue(llString, forKey: "ll")
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
