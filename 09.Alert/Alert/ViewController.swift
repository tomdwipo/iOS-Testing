//
//  ViewController.swift
//  Alert
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func buttonTap(){
        let alert = UIAlertController(title: "Do the thing?", message: "Let us know if you want to do thing", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in print(">> Cancel") }
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in print(">> OK") }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
        
        
    }


}

