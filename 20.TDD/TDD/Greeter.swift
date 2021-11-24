//
//  Greeter.swift
//  TDD
//
//  Created by RATAMATE on 24/11/21.
//

import Foundation

struct Greeter {
    private let greetingTimes: [(from: Int, greeting: String)] = [
        (0, "Good Evening"),
        (5, "Good morning"),
        (12, "Good afternoon"),
        (17, "Good Evening"),
        (24, "SENTINEL"),

    ]
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func greet(time: Date) -> String {
       
        
        let theHour = hour(for: time)
        for (index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour && theHour < greetingTimes[index + 1].from {
                if !name.isEmpty {
                    return "\(greetingTime.greeting), \(name)."
                }
                return greetingTime.greeting + "."
            }
        }
         return ""
    }
        
    private func hour(for time: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: time)
        return components.hour ?? 0
    }
}
