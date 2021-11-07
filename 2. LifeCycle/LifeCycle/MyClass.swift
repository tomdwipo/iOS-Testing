//
//  MyClass.swift
//  LifeCycle
//
//  Created by RATAMATE on 06/11/21.
//

import Foundation

class MyClass {
    private static var allInstances = 0
    private let instance: Int
    
    init(){
        MyClass.allInstances += 1
        instance = MyClass.allInstances
        print(">> MyClass.init() #\(instance)")
    }
    
    deinit {
        print(">> MyClass.deinit() #\(instance)")
    }
    
    func methodOne(){
        print(">> methodOne")
    }
    
    func methodTwo(){
        print(">> methodTwo")
    }
}
