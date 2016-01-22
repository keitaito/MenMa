//
//  StartInterfaceController.swift
//  MenMa
//
//  Created by Lynne Okada on 1/20/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class StartInterfaceController: WKInterfaceController, WCSessionDelegate {

    var session: WCSession!
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    @IBAction func startTapped() {
        pushControllerWithName("findRamen", context: ["segue": "pagebased", "data": "Passed through paage-based navigation"])
    
//        let messageToSend = ["value": "message sent successfully"]
//        session.sendMessage(messageToSend, replyHandler: { replyMessage in
//            //handle and present the message on screen
//            let value = replyMessage["value"] as? String
//            self.messageLabel.setText(value)
//            }, errorHandler: {error in
//                // catch any errors here
//                print(error)
//        })
    }
    
//    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
//        //handle received message
//        let value = message["value"] as? String
//        //use this to present immediately on the screen
//        dispatch_async(dispatch_get_main_queue()) {
//            self.messageLabel.setText(value)
//        }
//        //send a reply
//        replyHandler(["value":"RAMEN YEAH"])
//    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
