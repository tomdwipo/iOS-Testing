//
//  CodeNextViewController.swift
//  Navigation
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit

class CodeNextViewController: UIViewController {
    let label = UILabel()
    
    init(labelText: String) {
        self.label.text = labelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        activeEqualContraints(.centerX, fromItem: label, toItem: view)
        activeEqualContraints(.centerY, fromItem: label, toItem: view)
        // Do any additional setup after loading the view.
    }
    
    private func activeEqualContraints(_ attribute: NSLayoutConstraint.Attribute, fromItem: UIView, toItem: UIView){
        NSLayoutConstraint(item: fromItem, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: attribute, multiplier: 1, constant: 0).isActive = true
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
