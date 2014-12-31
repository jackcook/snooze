//
//  TutorialView.swift
//  Snooze
//
//  Created by Jack Cook on 12/31/14.
//  Copyright (c) 2014 CosmicByte. All rights reserved.
//

import AVFoundation
import UIKit

class TutorialView: UIView {
    
    var welcomeView: UIView!
    var background: UIImageView!
    var firstDot: UIImageView!
    var secondDot: UIImageView!
    var thirdDot: UIImageView!
    var fourthDot: UIImageView!
    var fifthDot: UIImageView!
    
    var cameraView: UIView!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    
    var currentView = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        var sgr = UISwipeGestureRecognizer(target: self, action: "changeView:")
        sgr.direction = .Left
        self.addGestureRecognizer(sgr)
        
        var rsgr = UISwipeGestureRecognizer(target: self, action: "changeView:")
        rsgr.direction = .Right
        self.addGestureRecognizer(rsgr)
        
        drawDots()
        drawWelcome()
        drawCamera()
        
        initializeCamera()
    }
    
    func changeView(sgr: UISwipeGestureRecognizer!) {
        if sgr.direction == .Right {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.welcomeView.frame.origin.x += deviceSize.width
                self.cameraView.frame.origin.x += deviceSize.width
            })
            
            currentView += 1
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.welcomeView.frame.origin.x -= deviceSize.width
                self.cameraView.frame.origin.x -= deviceSize.width
            })
            
            currentView -= 1
        }
    }
    
    func drawDots() {
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
        
        self.addSubview(firstDot)
        self.addSubview(secondDot)
        self.addSubview(thirdDot)
        self.addSubview(fourthDot)
        self.addSubview(fifthDot)
    }
    
    func drawWelcome() {
        welcomeView = UIView(frame: CGRectMake(0, 0, deviceSize.width, deviceSize.height))
        
        background = UIImageView(frame: self.bounds)
        background.image = UIImage(named: "background01.png")
        
        welcomeView.addSubview(background)
        self.addSubview(welcomeView)
    }
    
    func drawCamera() {
        cameraView = UIView(frame: CGRectMake(deviceSize.width, 0, deviceSize.width, deviceSize.height))
        
        initializeCamera()
        
        self.addSubview(cameraView)
    }
    
    func initializeCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        for device in AVCaptureDevice.devices() {
            if device.hasMediaType(AVMediaTypeVideo) {
                if device.position == AVCaptureDevicePosition.Back {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: nil))
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.cameraView.layer.addSublayer(previewLayer)
        previewLayer.frame = CGRectMake(0, 0, deviceSize.width, deviceSize.height)
        captureSession.startRunning()
    }
}
