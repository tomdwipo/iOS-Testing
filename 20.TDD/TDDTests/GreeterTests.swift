//
//  GreeterTests.swift
//  TDDTests
//
//  Created by RATAMATE on 24/11/21.
//

import XCTest
@testable import TDD

class GreeterWithoutNameTests: XCTestCase {
    private var sut: Greeter!
   
    override func setUp() {
        super.setUp()
        sut = Greeter(name: "")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_greet_with1159am_shouldSayGoodMorning(){
        let result = sut.greet(time: date(hour: 11, minute: 59))
        XCTAssertEqual(result, "Good morning.")
    }
    
    func test_greet_with1200pm_shouldSayGoodAfternoon(){
        let result = sut.greet(time: date(hour: 12, minute: 00))
        XCTAssertEqual(result, "Good afternoon.")
    }
    
    func test_greet_with459pm_shouldSayGoodAfternoon(){
        let result = sut.greet(time: date(hour: 16, minute: 59))
        XCTAssertEqual(result, "Good afternoon.")
    }
    
    func test_greet_with200pm_shouldSayGoodAfternoon(){
        let result = sut.greet(time: date(hour: 14, minute: 00))
        XCTAssertEqual(result, "Good afternoon.")
    }
    
    func test_greet_with1700_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 17, minute: 00))
        XCTAssertEqual(result, "Good Evening.")
    }
    
    func test_greet_with2359_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 23, minute: 59))
        XCTAssertEqual(result, "Good Evening.")
    }
    
    func test_greet_with2000_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 20, minute: 00))
        XCTAssertEqual(result, "Good Evening.")
    }
    
    func test_greet_with0000_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 00, minute: 00))
        XCTAssertEqual(result, "Good Evening.")
    }
    
    func test_greet_with459_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 4, minute: 59))
        XCTAssertEqual(result, "Good Evening.")
    }
    
    func test_greet_with200_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 2, minute: 0))
        XCTAssertEqual(result, "Good Evening.")
    }
    
    func test_greet_with500_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 5, minute: 0))
        XCTAssertEqual(result, "Good morning.")
    }
    
    func test_greet_with800_shouldSayGoodEvening(){
        let result = sut.greet(time: date(hour: 8, minute: 0))
        XCTAssertEqual(result, "Good morning.")
    }
}


class GreeterWithNameTests: XCTestCase {
    func test_greetMorning_withTommy_shouldSayGoodMorningTommy() {
        let sut = Greeter(name: "Tommy")
        let result = sut.greet(time: date(hour: 5, minute: 0))
        XCTAssertEqual(result, "Good morning, Tommy.")
    }
    
    func test_greetAfternoon_withDwi_shouldSayGoodAfternoonTommy() {
        let sut = Greeter(name: "Dwi")
        let result = sut.greet(time: date(hour: 15, minute: 0))
        XCTAssertEqual(result, "Good afternoon, Dwi.")
    }
}


private func date(hour: Int, minute: Int) -> Date {
    let components = DateComponents(calendar: Calendar.current, hour: hour, minute: minute)
    return components.date!
}
