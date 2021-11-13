//
//  TestError.swift
//  NetworkResponseTests
//
//  Created by RATAMATE on 13/11/21.
//

import Foundation

struct TestError: LocalizedError {
    let message: String
    
    var errorDescription: String? { message }
}
