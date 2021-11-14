//
//  TestHelpers.swift
//  TextFieldTests
//
//  Created by RATAMATE on 14/11/21.
//

import Foundation
import UIKit


func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

extension UITextContentType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension UITextAutocorrectionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return "default"
        case .no:
            return "no"
        case .yes:
            return "yes"
        @unknown default:
            fatalError("Uknown UITextAutocorrectionType")
        }
    }
}

extension UIReturnKeyType: CustomStringConvertible {
    public var description: String {
        switch self {
            
        case .`default`:
            return "default"
        
        case .go:
            return "go"
            
        case .google:
            return "google"
            
        case .join:
            return "join"
            
        case .next:
            return "join"
            
        case .route:
            return "route"
            
        case .search:
            return "search"
            
        case .send :
            return "send"
            
        case .yahoo :
            return "yahoo"
            
        case .done:
            return "done"
            
        case .emergencyCall:
            return "emergencyCall"
        @unknown default:
            fatalError("unknown UIReturnKeyType")
        }
    }
    
    
}
