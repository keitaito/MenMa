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
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        let mapLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37, -122)
        let regionSpan: MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
        ramenMap.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        
        ramenMap.setRegion(MKCoordinateRegionMake(mapLocation, regionSpan))
        
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
        
        let messageToSend = ["value": "message sent successfully"]
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
            //            //handle and present the message on screen
            //            let value = replyMessage["value"] as? Venue
            //            //            self.messageLabel.setText(value)
            }, errorHandler: {error in
                // catch any errors here
                print(error)
        })
        
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
