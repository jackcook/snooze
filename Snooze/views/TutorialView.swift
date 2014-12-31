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
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    
    var cameraView: UIView!
    var cameraLayer: UIView!
    var dotsBackground: UIView!
    var cameraButton: BFPaperButton!
    var retryButton: BFPaperButton!
    var finishedButton: BFPaperButton!
    var divider: UIImageView!
    var cameraTooltip: UIImageView!
    var tooltipTitle: UILabel!
    var tooltipBody: UILabel!
    var tooltipDoneButton: UIButton!
    
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
        
        drawWelcome()
        drawCamera()
        
        drawDots()
        
        initializeCamera()
    }
    
    func changeView(sgr: UISwipeGestureRecognizer!) {
        if currentView == 0 && sgr.direction == .Right {
            return
        }
        
        if sgr.direction == .Right {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.welcomeView.frame.origin.x += deviceSize.width
                self.cameraView.frame.origin.x += deviceSize.width
            })
            
            currentView -= 1
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.welcomeView.frame.origin.x -= deviceSize.width
                self.cameraView.frame.origin.x -= deviceSize.width
            })
            
            currentView += 1
        }
        
        firstDot.image = UIImage(named: "image02.png")
        secondDot.image = UIImage(named: "image02.png")
        thirdDot.image = UIImage(named: "image02.png")
        fourthDot.image = UIImage(named: "image02.png")
        fifthDot.image = UIImage(named: "image02.png")
        
        if currentView == 0 {
            firstDot.image = UIImage(named: "image01.png")
        } else if currentView == 1 {
            secondDot.image = UIImage(named: "image01.png")
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
        } else if currentView == 2 {
            thirdDot.image = UIImage(named: "image01.png")
        } else if currentView == 3 {
            fourthDot.image = UIImage(named: "image01.png")
        } else {
            fifthDot.image = UIImage(named: "image01.png")
        }
    }
    
    func drawDots() {
        let y = deviceSize.height - 36
        
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
        
        cameraLayer = UIView(frame: cameraView.bounds)
        
        var hideTooltip = UITapGestureRecognizer(target: self, action: "hideTooltip")
        hideTooltip.numberOfTapsRequired = 1
        cameraLayer.addGestureRecognizer(hideTooltip)
        
        dotsBackground = UIView(frame: CGRectMake(0, deviceSize.height - 60, deviceSize.width, 60))
        dotsBackground.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.8)
        
        cameraButton = BFPaperButton(frame: CGRectMake(0, deviceSize.height - 120, deviceSize.width, 60), raised: false)
        cameraButton.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.6)
        cameraButton.setImage(UIImage(named: "image03.png"), forState: .Normal)
        cameraButton.setImage(UIImage(named: "image03.png"), forState: .Highlighted)
        cameraButton.imageEdgeInsets = UIEdgeInsetsMake(10, (deviceSize.width - (40 * (163 / 137))) / 2, 10, (deviceSize.width - (40 * (163 / 137))) / 2)
        cameraButton.addTarget(self, action: "cameraButtonAction", forControlEvents: .TouchUpInside)
        
        retryButton = BFPaperButton(frame: CGRectMake(0, deviceSize.height - 120, deviceSize.width / 2, 60), raised: false)
        retryButton.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.6)
        retryButton.setImage(UIImage(named: "image05.png"), forState: .Normal)
        retryButton.setImage(UIImage(named: "image05.png"), forState: .Highlighted)
        retryButton.imageEdgeInsets = UIEdgeInsetsMake(14, ((deviceSize.width / 2) - (32 * (115 / 103))) / 2, 14, ((deviceSize.width / 2) - (32 * (115 / 103))) / 2)
        retryButton.alpha = 0
        retryButton.userInteractionEnabled = false
        
        finishedButton = BFPaperButton(frame: CGRectMake(deviceSize.width / 2, deviceSize.height - 120, deviceSize.width / 2, 60), raised: false)
        finishedButton.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.6)
        finishedButton.setImage(UIImage(named: "image07.png"), forState: .Normal)
        finishedButton.setImage(UIImage(named: "image07.png"), forState: .Highlighted)
        finishedButton.imageEdgeInsets = UIEdgeInsetsMake(14, ((deviceSize.width / 2) - (32 * (115 / 103))) / 2, 14, ((deviceSize.width / 2) - (32 * (115 / 103))) / 2)
        finishedButton.alpha = 0
        finishedButton.userInteractionEnabled = false
        
        var dividerImage = UIImage(named: "image06.png")
        divider = UIImageView(image: dividerImage)
        divider.frame = CGRectMake((deviceSize.width - 2) / 2, deviceSize.height - 110, 2, 40)
        divider.alpha = 0
        
        var image = UIImage(named: "image04.png")
        cameraTooltip = UIImageView(image: image)
        cameraTooltip.frame = CGRectMake((deviceSize.width - (image!.size.width * 0.3)) / 2, deviceSize.height - (image!.size.height * 0.3) - 114, image!.size.width * 0.3, image!.size.height * 0.3)
        
        tooltipTitle = UILabel()
        tooltipTitle.text = "TAKE A PHOTO"
        tooltipTitle.font = UIFont(name: "GillSans-Light", size: 24)
        tooltipTitle.textColor = UIColor(red: 0.39, green: 0.39, blue: 0.39, alpha: 1)
        tooltipTitle.sizeToFit()
        tooltipTitle.frame = CGRectMake((cameraTooltip.frame.size.width - tooltipTitle.frame.size.width) / 2, 24, tooltipTitle.frame.size.width, tooltipTitle.frame.size.height)
        
        tooltipBody = UILabel(frame: CGRectMake(28, -16, cameraTooltip.frame.size.width - 56, cameraTooltip.frame.size.height))
        tooltipBody.numberOfLines = 0
        tooltipBody.text = "Snooze will compare this photo to other photos you take when you wake up in order to turn off the alarm."
        tooltipBody.font = UIFont(name: "GillSans-Light", size: 16)
        
        tooltipDoneButton = UIButton()
        tooltipDoneButton.setTitle("OK", forState: .Normal)
        tooltipDoneButton.setTitleColor(UIColor(red: 0.55, green: 0.8, blue: 0.46, alpha: 1), forState: .Normal)
        tooltipDoneButton.setTitleColor(UIColor(red: 0.33, green: 0.49, blue: 0.24, alpha: 1), forState: .Highlighted)
        tooltipDoneButton.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        tooltipDoneButton.addTarget(self, action: "hideTooltip", forControlEvents: .TouchUpInside)
        tooltipDoneButton.sizeToFit()
        tooltipDoneButton.frame = CGRectMake((cameraTooltip.frame.size.width - tooltipDoneButton.frame.size.width) / 2, cameraTooltip.frame.size.height - tooltipDoneButton.frame.size.height - 36, tooltipDoneButton.frame.size.width, tooltipDoneButton.frame.size.height)
        
        cameraView.addSubview(cameraLayer)
        cameraView.addSubview(dotsBackground)
        cameraView.addSubview(cameraButton)
        cameraView.addSubview(retryButton)
        cameraView.addSubview(finishedButton)
        cameraView.addSubview(divider)
        cameraView.addSubview(cameraTooltip)
        cameraTooltip.addSubview(tooltipTitle)
        cameraTooltip.addSubview(tooltipBody)
        cameraTooltip.addSubview(tooltipDoneButton)
        self.addSubview(cameraView)
        
        initializeCamera()
    }
    
    func initializeCamera() -> Bool {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        for device in AVCaptureDevice.devices() {
            if device.hasMediaType(AVMediaTypeVideo) {
                if device.position == AVCaptureDevicePosition.Back {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice == nil {
            return false
        }
        
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: nil))
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraLayer.layer.addSublayer(previewLayer)
        previewLayer.frame = CGRectMake(0, 0, deviceSize.width, deviceSize.height)
        captureSession.startRunning()
        
        return true
    }
    
    func hideTooltip() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.cameraTooltip.alpha = 0
        }) { (done) -> Void in
            self.cameraTooltip.removeFromSuperview()
        }
    }
    
    func cameraButtonAction() {
        cameraButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.cameraButton.alpha = 0
            self.retryButton.alpha = 1
            self.divider.alpha = 1
            self.finishedButton.alpha = 1
        }) { (done) -> Void in
            self.retryButton.userInteractionEnabled = true
            self.finishedButton.userInteractionEnabled = true
        }
    }
}
