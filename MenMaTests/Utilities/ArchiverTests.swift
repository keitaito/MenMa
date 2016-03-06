//
//  ArchiverTests.swift
//  MenMa
//
//  Created by Keita Ito on 3/5/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import XCTest
import UIKit
import Quick
import Nimble
@testable import MenMa

class ArchiverTestsSpec: QuickSpec {
    override func spec() {
        describe("Archiver struct tests") {
            it("gets the class name of the passed object") {
                // given
                let object = Venue(name: "menma", id: "123", url: "menma.com")
                // when
                let name = Archvier<Venue>.getStringOfClassName(object)
                // then
                expect(name).to(equal(String(Venue)))
            }
            
            it("archives an object to data") {
                // given
                let strings = ["menma", "chashu", "naruto"] as [NSString]
                // when
                let aData = MenMa.Archvier.archive(strings)
                // then
                expect(aData).notTo(beNil())
                expect(aData).to(beAKindOf(NSData))
            }
            
            it("archives and unarchives a data to an object") {
                // given
                let strings = ["menma", "chashu", "naruto"] as [NSString]
                let aData = MenMa.Archvier.archive(strings)
                // when
                let archivedObject = MenMa.Archvier<NSString>.unarchive(aData)
                // then
                expect(archivedObject).notTo(beNil())
                guard let objects = archivedObject else { return }
                expect(objects[0]).to(equal("menma"))
                expect(objects[1]).to(equal("chashu"))
                expect(objects[2]).to(equal("naruto"))
            }
        }
    }
}
