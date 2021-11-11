//
//  MockUrlSession.swift
//  NetworkRequestTests
//
//  Created by RATAMATE on 11/11/21.
//

import Foundation
@testable import NetworkRequest

class MockUrlSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return DummyURLSessionDataTask()
    }
    
}


private class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        
    }
}
