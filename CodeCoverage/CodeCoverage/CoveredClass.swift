//
//  CoveredClass.swift
//  CodeCoverage
//
//  Created by RATAMATE on 07/11/21.
//

import Foundation
class CoveredClass {
    static func max(_ x: Int, _ y: Int) -> Int{
        if x < y {
            return y
        }
        return x
    }
    
    static func commaSeparated(from: Int, to: Int) -> String {
        var result = ""
        
        for i in from..<to {
            result += "\(i),"
        }
        result += "\(to)"
        return result
    }
}
