//
//  SnoozeViewController.swift
//  Snooze
//
//  Created by Jack Cook on 12/30/14.
//  Copyright (c) 2014 CosmicByte. All rights reserved.
//

import UIKit

class SnoozeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tutorial = TutorialView()
        self.view.addSubview(tutorial)
    }
}