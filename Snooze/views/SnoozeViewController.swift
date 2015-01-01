//
//  SnoozeViewController.swift
//  Snooze
//
//  Created by Jack Cook on 12/30/14.
//  Copyright (c) 2014 CosmicByte. All rights reserved.
//

import UIKit

class SnoozeViewController: UIViewController {
    
    var clock: ClockView!
    var tutorial: TutorialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue.name = "Drawing Queue"
        queue.addOperationWithBlock { () -> Void in
            self.clock = ClockView()
            self.clock.snoozeController = self
            self.view.addSubview(self.clock)
        }
        
        tutorial = TutorialView()
        tutorial.alpha = 0
        view.addSubview(self.tutorial)
    }
    
    func clockDone() {
        self.view.addSubview(tutorial)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.clock.alpha = 0
            self.tutorial.alpha = 1
        }) { (done) -> Void in
            self.clock.removeFromSuperview()
        }
    }
}