//
//  VenueTests.swift
//  MenMa
//
//  Created by Keita Ito on 2/6/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import MenMa

class VenueTests: XCTestCase {
}

class VenueTestsSpec: QuickSpec {
    override func spec() {
        describe("Venue class tests") {
            it("instantiates a Venue class with Keita's data") {
                let aVenue = Venue(name: "Ramen Keita-ya", id: "1234", url: "keita.com")
                expect(aVenue.name) == "Ramen Keita-ya"
                expect(aVenue.id) == "1234"
                expect(aVenue.url?.URLString) == "keita.com"
            }
            
            it("instantiates a Venue class with Lynne-chan's data") {
                // MARK - TODO: Please write a test here.
            }
            
            it("instantiates empty data, empty string, or nil if a property can take") {
                // MARK - TODO: Please write a test here.
            }
        }
    }
}