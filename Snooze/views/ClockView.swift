//
//  ClockView.swift
//  Snooze
//
//  Created by Jack Cook on 1/1/15.
//  Copyright (c) 2015 CosmicByte. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    var clock: UIImageView!
    var clockCenter: UIImageView!
    
    var secondHand: UIView!
    var minuteHand: UIView!
    var hourHand: UIView!
    
    var second = 0
    var minute = 0
    var hour = 0
    
    override init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var comps = calendar?.components(.SecondCalendarUnit | .MinuteCalendarUnit | .HourCalendarUnit, fromDate: NSDate())
        second = comps!.second
        minute = comps!.minute
        hour = comps!.hour
        
        self.backgroundColor = UIColor(red: 0.82, green: 0.81, blue: 0.8, alpha: 1)
        
        clock = UIImageView(frame: CGRectMake((deviceSize.width - 158) / 2, (deviceSize.height - 175) / 2, 158, 175))
        clock.image = UIImage(named: "image13.png")
        
        clockCenter = UIImageView(frame: CGRectMake((deviceSize.width - 10) / 2, (deviceSize.height - 10) / 2, 10, 10))
        clockCenter.image = UIImage(named: "image14.png")
        
        secondHand = UIView(frame: CGRectMake((deviceSize.width - 6) / 2, (deviceSize.height - 100) / 2, 3, 100))
        var secondColor = UIView(frame: CGRectMake(0, 0, 3, 50))
        secondColor.backgroundColor = UIColor(red: 0.73, green: 0.21, blue: 0.13, alpha: 1)
        secondHand.addSubview(secondColor)
        secondHand.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 3.9269)
        
        minuteHand = UIView(frame: CGRectMake((deviceSize.width - 6) / 2, (deviceSize.height - 80) / 2, 5, 80))
        var minuteColor = UIView(frame: CGRectMake(0, 0, 5, 40))
        minuteColor.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.23, alpha: 1)
        minuteHand.addSubview(minuteColor)
        minuteHand.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0)
        
        hourHand = UIView(frame: CGRectMake((deviceSize.width - 6) / 2, (deviceSize.height - 50) / 2, 5, 50))
        var hourColor = UIView(frame: CGRectMake(0, 0, 5, 25))
        hourColor.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.23, alpha: 1)
        hourHand.addSubview(hourColor)
        hourHand.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 1.5707)
        
        self.addSubview(clock)
        self.addSubview(secondHand)
        self.addSubview(minuteHand)
        self.addSubview(hourHand)
        self.addSubview(clockCenter)
        
        animateClock()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateClock() {
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.secondHand.transform = self.r(0.7853)
            self.minuteHand.transform = self.r(CGFloat(M_PI / 2))
            self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI / 4))
        }) { (done) -> Void in
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                self.secondHand.transform = self.r(3.9268)
                self.minuteHand.transform = self.r(CGFloat(M_PI))
                self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI / 2))
            }, completion: { (done) -> Void in
                UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    self.secondHand.transform = self.r(0.7851)
                    self.minuteHand.transform = self.r(CGFloat(M_PI + (M_PI / 2)))
                    self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI * (3/4)))
                }, completion: { (done) -> Void in
                    UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                        self.secondHand.transform = self.r(3.9266)
                        self.minuteHand.transform = self.r(0)
                        self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI))
                    }, completion: { (done) -> Void in
                        UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                            self.secondHand.transform = self.r(0.7849)
                            self.minuteHand.transform = self.r(CGFloat(M_PI / 2))
                            self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI + (M_PI / 4)))
                        }, completion: { (done) -> Void in
                            UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                                self.secondHand.transform = self.r(3.9264)
                                self.minuteHand.transform = self.r(CGFloat(M_PI))
                                self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI + (M_PI / 2)))
                            }, completion: { (done) -> Void in
                                UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                                    self.secondHand.transform = self.r(0.7847)
                                    self.minuteHand.transform = self.r(CGFloat(M_PI + (M_PI / 2)))
                                    self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI + (M_PI * (3/4))))
                                }, completion: { (done) -> Void in
                                    UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: { () -> Void in
                                        self.secondHand.transform = self.r(3.9262)
                                        self.minuteHand.transform = self.r(0)
                                        self.hourHand.transform = self.r(1.5707 + CGFloat(M_PI * 2))
                                    }, completion: { (done) -> Void in
                                        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                                            var secondTransform = atan2(self.secondHand.transform.b, self.secondHand.transform.a)
                                            self.secondHand.transform = self.r((((CGFloat(M_PI * 2) / 60) * CGFloat(self.second)) + secondTransform) / 2)
                                            self.secondHand.transform = self.r((CGFloat(M_PI * 2) / 60) * CGFloat(self.second))
                                            
                                            var minuteTransform = atan2(self.minuteHand.transform.b, self.minuteHand.transform.a)
                                            self.minuteHand.transform = self.r((((CGFloat(M_PI * 2) / 60) * CGFloat(self.minute)) + minuteTransform) / 2)
                                            self.minuteHand.transform = self.r((CGFloat(M_PI * 2) / 60) * CGFloat(self.minute))
                                            
                                            var hourTransform = atan2(self.hourHand.transform.b, self.hourHand.transform.a)
                                            self.hourHand.transform = self.r((((CGFloat(M_PI * 2) / 12) * CGFloat(self.hour)) + hourTransform) / 2)
                                            self.hourHand.transform = self.r((CGFloat(M_PI * 2) / 12) * CGFloat(self.hour))
                                        }, completion: { (done) -> Void in
                                            self.actuallyAnimateClock()
                                            var timer = NSTimer(timeInterval: 1, target: self, selector: "actuallyAnimateClock", userInfo: nil, repeats: true)
                                            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        }
    }
    
    func actuallyAnimateClock() {
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var comps = calendar?.components(.SecondCalendarUnit | .MinuteCalendarUnit | .HourCalendarUnit, fromDate: NSDate())
        second = comps!.second
        minute = comps!.minute
        hour = comps!.hour
        
        var secondRotate = M_PI / 30 * Double(second)
        var minuteRotate = M_PI / 30 * Double(minute)
        var hourRotate = M_PI / 6 * Double(hour)
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.secondHand.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(secondRotate))
            self.minuteHand.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(minuteRotate))
            self.hourHand.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(hourRotate))
        }) { (done) -> Void in
            
        }
    }
    
    func r(angle: CGFloat) -> CGAffineTransform {
        return CGAffineTransformRotate(CGAffineTransformIdentity, angle)
    }
}
