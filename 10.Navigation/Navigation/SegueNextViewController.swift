//
//  SegueViewController.swift
//  Navigation
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit

class SegueNextViewController: UIViewController {
   
    var labelText: String?
    
    @IBOutlet private(set) var label: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = labelText
        // Do any additional setup after loading the view.
    }
    
    deinit{
        print(">> SegueNextViewController.deinit")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
