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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}

@available(iOS 9, *)
class MainViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: MenMa.MainViewController!
        
        describe("create viewController") {
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            }
            
            it("checks view controller is not nil") {
                expect(viewController).notTo(equal(nil))
            }
            
            it("calls viewDidLoad") {
                let _ = viewController.view
                guard let aView = viewController.view.subviews.last else { return }
                expect(aView.backgroundColor).to(equal(UIColor.redColor()))
            }
        }
    }
}
