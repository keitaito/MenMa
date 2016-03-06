//
//  InterfaceController.swift
//  MenMa WatchKit Extension
//
//  Created by Keita Ito on 6/13/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import WatchKit
import Foundation
import MapKit
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet var messageLabel: WKInterfaceLabel!
    @IBOutlet var ramenMap: WKInterfaceMap!
    @IBOutlet var ramenTableView: WKInterfaceTable!
    
    // MARK: - Properties
    
//    let sharedDefaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.keitaito.MenMa")!
//    //var tempArray: NSArray = ["tonkotsu🍜","shoyu🍜","miso🍜"]
    
    var session: WCSession!
    var cachedRamenPlaceNames: [String]? = []
    
    // MARK: - Life cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Set up WCSession.
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        // Set up the current location.
        let mapLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37, -122)
        let regionSpan: MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
        ramenMap.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        ramenMap.setRegion(MKCoordinateRegionMake(mapLocation, regionSpan))
        
        // Send a message to wake up iOS.
        let message = ["message" : "watch wants iOS to wake up."]
        session.sendMessage(message, replyHandler: { replyMessage -> Void in
            // When iOS receives a message, send back a reply to watch.
            if let reply = replyMessage["reply"] as? String {
                print(reply)
            }
            
            // After waking iOS up, send a message to ask iOS to download venues data.
            let messageForDownloading = ["message": "download"]
            self.session.sendMessage(messageForDownloading, replyHandler: { (replyMessage) -> Void in
                // when iOS receives a message, send back a reply to watch.
                print(replyMessage)
                
                // download message's error.
                }, errorHandler: { (error) -> Void in
                    print(error.localizedDescription)
            })
            
            // wake up message's error.
            }, errorHandler: { (error) -> Void in
                print(error.localizedDescription)
        })
        
//        cachedRamenPlaceNames = sharedDefaults.objectForKey("ramenPlaceNames") as? [String]
//        if let cachedRamenPlaceNames = cachedRamenPlaceNames {
//            self.configureRamenTableView(cachedRamenPlaceNames)
//        } else {
//            self.configureRamenTableView(NSArray())
//        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // MARK: - Private methods
    
    private func configureRamenTableView<T> (dataObjects: Array<T>) {
//        guard let cachedRamenPlaceNames = cachedRamenPlaceNames else {return}
        ramenTableView.setNumberOfRows(dataObjects.count, withRowType: "ramenRowController")
        for i in dataObjects.indices {
            let ramenRow: RamenRowController = self.ramenTableView.rowControllerAtIndex(i) as! RamenRowController
            let venue = dataObjects[i] as? Venue
            if let venue = venue {
                ramenRow.ramenLabel.setText(venue.name)
            }
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        //handle received message
        let value = message["value"] as? String
        //use this to present immediately on the screen
        dispatch_async(dispatch_get_main_queue()) {
            self.messageLabel.setText(value)
        }
        //send a reply
        replyHandler(["value":"RAMEN YEAH"])
    }
    
    func session(session: WCSession, didReceiveMessageData messageData: NSData, replyHandler: (NSData) -> Void) {
        // Convert venues from NSData type to Venue type.
        let unarchivedVenues = Archvier<Venue>.unarchive(messageData)
        guard let venues = unarchivedVenues else { return }
        venues.forEach {
            print($0.name)
        }
        configureRamenTableView(venues)
    }
}
