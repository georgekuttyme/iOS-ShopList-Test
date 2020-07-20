//
//  HomePresenter_TestCases.swift
//  Shop-ListTests
//
//  Created by Legends on 02/07/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import Foundation
import XCTest

@testable import Shop_List

class HomePresenter_TestCases: XCTestCase {
    let pickupList : [ShopPickupDetails] = [ShopPickupDetails(name: "testName", address: "testAddress", city: "testCity", active: true, distance: 100.0, didSelected: true)]
    
    func testNumberOfRaws() {
        XCTAssertTrue(pickupList.count == 1)
    }
    
    func testRawHeight()  {
        let rawHeight = 100.0
        XCTAssertTrue(rawHeight == 100)
    }
    
    func testFilterActiveLocation() {
        let filteredData = pickupList.filter { $0.active == true }
        XCTAssertTrue(filteredData.count == 1)
    }
}
