//
//  ViewController.swift
//  UserDefaults
//
//  Created by RATAMATE on 10/11/21.
//

import UIKit
protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey defaultName: String)
    func integer(forKey defaultName: String) -> Int
}


extension UserDefaults: UserDefaultsProtocol {
    
}


class ViewController: UIViewController {
    var userDefaults: UserDefaultsProtocol = UserDefaults.standard
    
    @IBOutlet private(set) var counterLabel: UILabel!
    @IBOutlet private(set) var incrementButton: UIButton!
    
    private var count = 0 {
        didSet{
            counterLabel.text = "\(count)"
            userDefaults.set(count, forKey: "count")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = userDefaults.integer(forKey: "count")
    }

    @IBAction private func incrementButtonTapped(){
        count += 1
    }

}
