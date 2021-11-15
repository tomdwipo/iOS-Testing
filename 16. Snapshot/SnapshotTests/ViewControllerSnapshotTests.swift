//
//  ViewControllerSnapshotTests.swift
//  SnapshotTests
//
//  Created by RATAMATE on 15/11/21.
//

import XCTest
@testable import Snapshot
import FBSnapshotTestCase

class ViewControllerSnapshotTets: FBSnapshotTestCase {
   
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test_example(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut = sb.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        
        FBSnapshotVerifyViewController(sut)
        
        
    }
}

