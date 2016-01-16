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

    @IBOutlet var ramenMap: WKInterfaceMap!
    @IBOutlet var ramenTableView: WKInterfaceTable!
    let sharedDefaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.keitaito.MenMa")!
    //var tempArray: NSArray = ["tonkotsu🍜","shoyu🍜","miso🍜"]
    var cachedRamenPlaceNames: [String]? = []
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        let value = message["Value"] as? String
        print(value)
    }
    
//    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
//        //handle received message
//        let value = message["Value"] as? String
//        //use this to present immediately on the screen
//        dispatch_async(dispatch_get_main_queue()) {
//            self.messageLabel.setText(value)
//        }
//        //send a reply
//        replyHandler(["Value":"Yes"])
//    }
    
//    @IBAction func findRamen() {
//        print("find ramen")
//    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let mapLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37, -122)
        let regionSpan: MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
        ramenMap.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        
        ramenMap.setRegion(MKCoordinateRegionMake(mapLocation, regionSpan))
        
        cachedRamenPlaceNames = sharedDefaults.objectForKey("ramenPlaceNames") as? [String]
        if let cachedRamenPlaceNames = cachedRamenPlaceNames {
            self.configureRamenTableView(cachedRamenPlaceNames)
        } else {
            self.configureRamenTableView(NSArray())
        }
        
        print("test")
    }

    func configureRamenTableView (dataObjects: NSArray) {
        guard let cachedRamenPlaceNames = cachedRamenPlaceNames else {return}
        ramenTableView.setNumberOfRows(dataObjects.count, withRowType: "ramenRowController")
        for var i = 0; i < cachedRamenPlaceNames.count; ++i {
            let ramenRow: RamenRowController = self.ramenTableView.rowControllerAtIndex(i) as! RamenRowController
            let dataObject: NSString = dataObjects.objectAtIndex(i) as! NSString
            
            ramenRow.ramenLabel.setText(dataObject as String)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}