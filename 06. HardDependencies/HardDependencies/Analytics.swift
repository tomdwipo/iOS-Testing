//
//  Analytics.swift
//  HardDependencies
//
//  Created by RATAMATE on 08/11/21.
//

import Foundation

class Analytics {
    static let shared = Analytics()
    
    func track(event: String){
        print(">> \(event)")
        
        if self !== Analytics.shared {
            print(">> ...Not the analytics singleton")
        }
    }
}
