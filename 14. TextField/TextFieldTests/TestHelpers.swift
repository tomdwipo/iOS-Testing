//
//  TestHelpers.swift
//  TextFieldTests
//
//  Created by RATAMATE on 14/11/21.
//

import Foundation
import UIKit

func putInViewHierarchy(_ vc: UIViewController){
    let window = UIWindow()
    window.addSubview(vc.view)
}

@discardableResult func shouldReturn(in textField: UITextField) -> Bool? {
    textField.delegate?.textFieldShouldReturn?(textField)
}

func shouldChangeCharacters(in textField: UITextField, range: NSRange = NSRange(), replacement: String) -> Bool? {
    textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: replacement)
}

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
        case .continue:
            return "continue"
        @unknown default:
            fatalError("unknown UIReturnKeyType")
        }
    }
    
    
}
