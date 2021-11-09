//
//  OutletConnectionsViewControllerTests.swift
//  OutletConnectionsTests
//
//  Created by RATAMATE on 09/11/21.
//

import XCTest
@testable import OutletConnections

class OutletConnectionsViewControllerTests: XCTestCase {
  
    func test_outlets_shouldBeConnected(){
        let sut = OutletConnectionsViewController()
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.label, "label")
        XCTAssertNotNil(sut.button, "button")
        
    }

}
