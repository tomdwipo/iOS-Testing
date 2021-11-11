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
        XCTAssertEqual(dataTaskCallCount, 1, "Call count",  file: file, line: line)
        XCTAssertEqual(dataTaskArgsRequest.first, request, "request",  file: file, line: line)
    }
    
}


private class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        
    }
}
