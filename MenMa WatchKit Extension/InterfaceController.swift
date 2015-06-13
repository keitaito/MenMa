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


class InterfaceController: WKInterfaceController {

    @IBOutlet var ramenMap: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let mapLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37, -122)
        let regionSpan: MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
        ramenMap.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Purple)
        
        
        ramenMap.setRegion(MKCoordinateRegionMake(mapLocation, regionSpan))
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
