//
//  TutorialView.swift
//  Snooze
//
//  Created by Jack Cook on 12/31/14.
//  Copyright (c) 2014 CosmicByte. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    
    var background: UIImageView!
    var firstDot: UIImageView!
    var secondDot: UIImageView!
    var thirdDot: UIImageView!
    var fourthDot: UIImageView!
    var fifthDot: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        drawWelcome()
    }
    
    func drawWelcome() {
        background = UIImageView(frame: self.bounds)
        background.image = UIImage(named: "background01.png")
        
        let y = deviceSize.height - 48
        
        firstDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) - 54, y, 12, 12))
        firstDot.image = UIImage(named: "image01.png")
        
        secondDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) - 30, y, 12, 12))
        secondDot.image = UIImage(named: "image02.png")
        
        thirdDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) - 6, y, 12, 12))
        thirdDot.image = UIImage(named: "image02.png")
        
        fourthDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) + 18, y, 12, 12))
        fourthDot.image = UIImage(named: "image02.png")
        
        fifthDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) + 42, y, 12, 12))
        fifthDot.image = UIImage(named: "image02.png")
        
        self.addSubview(background)
        self.addSubview(firstDot)
        self.addSubview(secondDot)
        self.addSubview(thirdDot)
        self.addSubview(fourthDot)
        self.addSubview(fifthDot)
    }
}
