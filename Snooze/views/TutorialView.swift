//
//  TutorialView.swift
//  Snooze
//
//  Created by Jack Cook on 12/31/14.
//  Copyright (c) 2014 CosmicByte. All rights reserved.
//

import AVFoundation
import UIKit

class TutorialView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var welcomeView: UIView!
    var background: UIImageView!
    var firstDot: UIImageView!
    var secondDot: UIImageView!
    var thirdDot: UIImageView!
    var fourthDot: UIImageView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    var stillImageOutput: AVCaptureStillImageOutput!
    var imageTaken: UIImage!
    
    var cameraView: UIView!
    var cameraLayer: UIView!
    var finishedImage: UIImageView!
    var dotsBackground: UIView!
    var cameraButton: BFPaperButton!
    var retryButton: BFPaperButton!
    var finishedButton: BFPaperButton!
    var divider: UIImageView!
    var cameraTooltip: UIImageView!
    var tooltipTitle: UILabel!
    var tooltipBody: UILabel!
    var tooltipDoneButton: UIButton!
    
    var am = true
    
    var alarmView: UIView!
    var alarmTitle: UILabel!
    var alarmClockImage: UIImageView!
    var alarmHourPicker: UIPickerView!
    var alarmDivider: UIImageView!
    var alarmMinutePicker: UIPickerView!
    var alarmAMPMButton: UIButton!
    var alarmTooltip: UIImageView!
    var alarmImage: UIImageView!
    var alarmDotsBackground: UIView!
    
    var hours = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var minutes = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    
    var congratsView: UIView!
    var congratsBackground: UIImageView!
    var congratsDoneButton: UIButton!
    var congratsDotsBackground: UIView!
    
    var currentView = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        var sgr = UISwipeGestureRecognizer(target: self, action: "changeViewGestureRecognizer:")
        sgr.direction = .Left
        self.addGestureRecognizer(sgr)
        
        var rsgr = UISwipeGestureRecognizer(target: self, action: "changeViewGestureRecognizer:")
        rsgr.direction = .Right
        self.addGestureRecognizer(rsgr)
        
        drawWelcome()
        drawCamera()
        drawAlarm()
        drawCongrats()
        
        drawDots()
        
        initializeCamera()
    }
    
    func changeViewGestureRecognizer(sgr: UISwipeGestureRecognizer!) {
        changeView(sgr.direction == .Left)
    }
    
    func changeView(next: Bool) {
        if currentView == 0 && !next {
            return
        }
        
        if let img = imageTaken {} else {
            if currentView == 1 && next {
                return
            }
        }
        
        if next {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.welcomeView.frame.origin.x -= deviceSize.width
                self.cameraView.frame.origin.x -= deviceSize.width
                self.alarmView.frame.origin.x -= deviceSize.width
                self.congratsView.frame.origin.x -= deviceSize.width
            })
            
            currentView += 1
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.welcomeView.frame.origin.x += deviceSize.width
                self.cameraView.frame.origin.x += deviceSize.width
                self.alarmView.frame.origin.x += deviceSize.width
                self.congratsView.frame.origin.x += deviceSize.width
            })
            
            currentView -= 1
        }
        
        firstDot.image = UIImage(named: "image02.png")
        secondDot.image = UIImage(named: "image02.png")
        thirdDot.image = UIImage(named: "image02.png")
        fourthDot.image = UIImage(named: "image02.png")
        
        if currentView == 0 {
            firstDot.image = UIImage(named: "image01.png")
        } else if currentView == 1 {
            secondDot.image = UIImage(named: "image01.png")
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
        } else if currentView == 2 {
            thirdDot.image = UIImage(named: "image01.png")
        } else if currentView == 3 {
            fourthDot.image = UIImage(named: "image01.png")
        }
    }
    
    func drawDots() {
        let y = deviceSize.height - 36
        
        firstDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) - 42, y, 12, 12))
        firstDot.image = UIImage(named: "image01.png")
        
        secondDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) - 18, y, 12, 12))
        secondDot.image = UIImage(named: "image02.png")
        
        thirdDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) + 6, y, 12, 12))
        thirdDot.image = UIImage(named: "image02.png")
        
        fourthDot = UIImageView(frame: CGRectMake((deviceSize.width / 2) + 30, y, 12, 12))
        fourthDot.image = UIImage(named: "image02.png")
        
        self.addSubview(firstDot)
        self.addSubview(secondDot)
        self.addSubview(thirdDot)
        self.addSubview(fourthDot)
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
        
        finishedImage = UIImageView(frame: cameraLayer.bounds)
        finishedImage.alpha = 0
        
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
        retryButton.addTarget(self, action: "retryButtonAction", forControlEvents: .TouchUpInside)
        
        finishedButton = BFPaperButton(frame: CGRectMake(deviceSize.width / 2, deviceSize.height - 120, deviceSize.width / 2, 60), raised: false)
        finishedButton.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.6)
        finishedButton.setImage(UIImage(named: "image07.png"), forState: .Normal)
        finishedButton.setImage(UIImage(named: "image07.png"), forState: .Highlighted)
        finishedButton.imageEdgeInsets = UIEdgeInsetsMake(14, ((deviceSize.width / 2) - (32 * (115 / 103))) / 2, 14, ((deviceSize.width / 2) - (32 * (115 / 103))) / 2)
        finishedButton.alpha = 0
        finishedButton.userInteractionEnabled = false
        finishedButton.addTarget(self, action: "finishedButtonAction", forControlEvents: .TouchUpInside)
        
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
        cameraView.addSubview(finishedImage)
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
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        captureSession.addOutput(stillImageOutput)
        
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
        
        var videoConnection: AVCaptureConnection?
        for connection in stillImageOutput.connections {
            for port in connection.inputPorts as [AVCaptureInputPort] {
                if port.mediaType == AVMediaTypeVideo {
                    videoConnection = connection as? AVCaptureConnection
                    break
                }
            }
            if let c = videoConnection {
                break
            }
        }
        
        stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (imageSampleBuffer, error) -> Void in
            var data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
            self.imageTaken = UIImage(data: data)
            self.finishedImage.image = self.imageTaken
            self.alarmImage.image = self.imageTaken
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.finishedImage.alpha = 1
            })
        })
        
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
    
    func retryButtonAction() {
        self.retryButton.userInteractionEnabled = false
        self.finishedButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.cameraButton.alpha = 1
            self.retryButton.alpha = 0
            self.divider.alpha = 0
            self.finishedButton.alpha = 0
            
            self.finishedImage.alpha = 0
        }) { (done) -> Void in
            self.cameraButton.userInteractionEnabled = true
        }
    }
    
    func finishedButtonAction() {
        changeView(true)
    }
    
    func drawAlarm() {
        alarmView = UIView(frame: CGRectMake(deviceSize.width * 2, 0, deviceSize.width, deviceSize.height))
        
        alarmTitle = UILabel()
        alarmTitle.text = "SET YOUR ALARM"
        alarmTitle.font = UIFont(name: "GillSans-Light", size: 24)
        alarmTitle.textColor = UIColor(red: 0.39, green: 0.39, blue: 0.39, alpha: 1)
        alarmTitle.sizeToFit()
        alarmTitle.frame = CGRectMake((deviceSize.width - alarmTitle.frame.size.width) / 2, 36, alarmTitle.frame.size.width, alarmTitle.frame.size.height)
        
        var y = alarmTitle.frame.size.height
        var contentRect = CGRectMake(0, y, deviceSize.width, deviceSize.height - y - 60 - (deviceSize.width / (16 / 9)))
        
        alarmClockImage = UIImageView(frame: CGRectMake((deviceSize.width / 4) - 48, contentRect.origin.y + ((contentRect.size.height - 56) / 2), 56, 56))
        alarmClockImage.image = UIImage(named: "image08.png")
        
        alarmHourPicker = UIPickerView(frame: CGRectMake((deviceSize.width / 2) - 72, contentRect.origin.y + ((contentRect.size.height - 164) / 2), 72, 100))
        alarmHourPicker.tag = 0
        alarmHourPicker.delegate = self
        alarmHourPicker.dataSource = self
        alarmHourPicker.selectRow(5, inComponent: 0, animated: false)
        
        alarmDivider = UIImageView(frame: CGRectMake((deviceSize.width - 2) / 2, contentRect.origin.y + (contentRect.size.height - (contentRect.size.height / 3)) / 2, 2, contentRect.size.height / 3))
        alarmDivider.image = UIImage(named: "image09.png")
        
        alarmMinutePicker = UIPickerView(frame: CGRectMake(deviceSize.width / 2, contentRect.origin.y + ((contentRect.size.height - 164) / 2), 72, 100))
        alarmMinutePicker.tag = 1
        alarmMinutePicker.delegate = self
        alarmMinutePicker.dataSource = self
        alarmMinutePicker.selectRow(30, inComponent: 0, animated: false)
        
        alarmAMPMButton = UIButton(frame: CGRectMake(((deviceSize.width / 4) * 3) - 10, contentRect.origin.y + ((contentRect.size.height - 30) / 2), 24, 30))
        alarmAMPMButton.setImage(UIImage(named: "image10.png"), forState: .Normal)
        alarmAMPMButton.setImage(UIImage(named: "image10.png"), forState: .Highlighted)
        alarmAMPMButton.addTarget(self, action: "alarmAMPMButtonAction", forControlEvents: .TouchUpInside)
        
        alarmImage = UIImageView(frame: CGRectMake(0, deviceSize.height - 60 - (deviceSize.width / (16 / 9)), deviceSize.width, (deviceSize.width / (16 / 9)) + 60))
        alarmImage.contentMode = .ScaleAspectFill
        alarmImage.clipsToBounds = true
        alarmImage.backgroundColor = UIColor.blackColor()
        
        alarmDotsBackground = UIView(frame: CGRectMake(0, deviceSize.height - 60, deviceSize.width, 60))
        alarmDotsBackground.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.8)
        
        alarmView.addSubview(alarmTitle)
        alarmView.addSubview(alarmClockImage)
        alarmView.addSubview(alarmHourPicker)
        alarmView.addSubview(alarmDivider)
        alarmView.addSubview(alarmMinutePicker)
        alarmView.addSubview(alarmAMPMButton)
        alarmView.addSubview(alarmImage)
        alarmView.addSubview(alarmDotsBackground)
        self.addSubview(alarmView)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0 ? hours.count : minutes.count
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        (pickerView.subviews[1] as UIView).hidden = true
        (pickerView.subviews[2] as UIView).hidden = true
        
        if let label = view as? UILabel {
            return label
        } else {
            var label = UILabel()
            label.text = pickerView.tag == 0 ? hours[row] : minutes[row]
            label.textAlignment = .Center
            label.font = UIFont(name: "GillSans-Light", size: 36)
            return label
        }
    }
    
    func alarmAMPMButtonAction() {
        if am {
            alarmAMPMButton.setImage(UIImage(named: "image11.png"), forState: .Normal)
            alarmAMPMButton.setImage(UIImage(named: "image11.png"), forState: .Highlighted)
        } else {
            alarmAMPMButton.setImage(UIImage(named: "image10.png"), forState: .Normal)
            alarmAMPMButton.setImage(UIImage(named: "image10.png"), forState: .Highlighted)
        }
        
        am = !am
    }
    
    func drawCongrats() {
        congratsView = UIView(frame: CGRectMake(deviceSize.width * 3, 0, deviceSize.width, deviceSize.height))
        
        congratsBackground = UIImageView(frame: self.bounds)
        congratsBackground.image = UIImage(named: "background02.png")
        
        congratsDoneButton = UIButton()
        congratsDoneButton.setTitle("START", forState: .Normal)
        congratsDoneButton.setTitleColor(UIColor(red: 0.55, green: 0.8, blue: 0.46, alpha: 1), forState: .Normal)
        congratsDoneButton.setTitleColor(UIColor(red: 0.33, green: 0.49, blue: 0.24, alpha: 1), forState: .Highlighted)
        congratsDoneButton.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        congratsDoneButton.addTarget(self, action: "congratsDoneButtonAction", forControlEvents: .TouchUpInside)
        congratsDoneButton.sizeToFit()
        congratsDoneButton.frame = CGRectMake((deviceSize.width - congratsDoneButton.frame.size.width) / 2, ((deviceSize.height - congratsDoneButton.frame.size.height) / 2) + (deviceSize.height / 4), congratsDoneButton.frame.size.width, congratsDoneButton.frame.size.height)
        
        congratsDotsBackground = UIView(frame: CGRectMake(0, deviceSize.height - 60, deviceSize.width, 60))
        congratsDotsBackground.backgroundColor = UIColor(red: 0.53, green: 0.79, blue: 0.45, alpha: 0.8)
        
        congratsView.addSubview(congratsBackground)
        congratsView.addSubview(congratsDoneButton)
        congratsView.addSubview(congratsDotsBackground)
        self.addSubview(congratsView)
    }
    
    func congratsDoneButtonAction() {
        // success!
    }
}
