//
//  MainViewControllerTests.swift
//  MenMa
//
//  Created by Keita Ito on 2/5/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import MenMa

class MainViewControllerTests: XCTestCase {
}

@available(iOS 9, *)
class MainViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: MenMa.MainViewController!
        
        describe("viewController tests") {
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                // Call viewDidLoad.
                let _ = viewController.view
            }
            
            it("checks view controller is not nil") {
                expect(viewController).notTo(equal(nil))
            }
            
            it("viewDidLoad should be called") {
                guard let aView = viewController.view.subviews.last else { return }
                expect(aView.backgroundColor).to(equal(UIColor.redColor()))
            }
            
            it("taps redownloadButton, and 30 venues should be stored in venues property") {
                viewController.redownloadButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                // Test downloading venues.
                expect(viewController.venues.count).toEventually(equal(30))
            }
        }
    }
}
