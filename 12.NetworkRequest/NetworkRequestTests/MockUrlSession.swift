//
//  MockUrlSession.swift
//  NetworkRequestTests
//
//  Created by RATAMATE on 11/11/21.
//

import Foundation
@testable import NetworkRequest
import XCTest

class MockUrlSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return DummyURLSessionDataTask()
    }
    
    func verifyDataTask(with request: URLRequest, file: StaticString = #file, line: UInt = #line) {
        guard dataTaskWasCalledOne(file: file, line: line) else { return }
        XCTAssertEqual(dataTaskArgsRequest.first, request, "request",  file: file, line: line)
    }
    
    private func dataTaskWasCalledOne(file: StaticString = #file, line: UInt = #line) -> Bool {
        verifyMethodCalledOnce(methodName: "dataTask(with:completionHandler)", callCount: dataTaskCallCount, describeArguments: "request: \(dataTaskArgsRequest)", file: file, line: line)
    }
    
    func verifyMethodCalledOnce(methodName: String, callCount: Int, describeArguments: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Bool {
        if callCount == 0 {
            XCTFail("Wanted but not invoked: \(methodName)", file: file, line: line)
            return false
        }
        if callCount > 1 {
            XCTFail("Wanted 1 times but was called: \(methodName)", file: file, line: line)
            return false
        }
        return true
    }
    
}


private class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        
    }
}
