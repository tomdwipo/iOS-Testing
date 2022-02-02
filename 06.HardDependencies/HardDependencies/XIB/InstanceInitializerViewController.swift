//
//  InstanceInitializerViewController.swift
//  HardDependencies
//
//  Created by RATAMATE on 08/11/21.
//

import UIKit

class InstanceInitializerViewController: UIViewController {
    private let analytics: Analytics
  
    init(analytics: Analytics = Analytics.shared) {
        self.analytics = analytics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics.track(event: "viewDidAppear \(type(of: self))")
    }
}
