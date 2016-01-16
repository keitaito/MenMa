//
//  ViewController.swift
//  MenMa
//
//  Created by Keita Ito on 6/13/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import UIKit
import WatchConnectivity

@available(iOS 9.0, *)
class ViewController: UIViewController, WCSessionDelegate {

    var session: WCSession!
    @IBOutlet weak var sendButton: UIButton!
    var url: NSURL?
    var cachedRamenNames: [String] = []
    let sharedDefaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.keitaito.MenMa")!
    
    @IBAction func sendButton(sender: AnyObject) {
        print("tap")
        //Send Message to WatchKit
        let messageToSend = ["ramen":cachedRamenNames]
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
            //handle the reply
//            let value = replyMessage["Value"] as? String
            //use dispatch_asynch to present immediately on screen
//            dispatch_async(dispatch_get_main_queue()) {
//                self.messageLabel.text = value
//            }
            }, errorHandler: {error in
                // catch any errors here
                print(error)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
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
            
            let messageToSend = ["ramen":self.cachedRamenNames]
            self.session.sendMessage(messageToSend, replyHandler: { replyMessage in
                //handle the reply
                //            let value = replyMessage["Value"] as? String
                //use dispatch_asynch to present immediately on screen
                //            dispatch_async(dispatch_get_main_queue()) {
                //                self.messageLabel.text = value
                //            }
                }, errorHandler: {error in
                    // catch any errors here
                    print(error)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

