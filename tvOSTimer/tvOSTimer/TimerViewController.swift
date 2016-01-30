//
//  ViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: Custom Transition Animation Variable
    let zScaleVerticalAnimationController = ZScaleVerticalAnimationController()
    
    //MARK: Timer Variables
    var timer: NSTimer?
    var secondsToCountdown = CGFloat()
    var timerStaticValue = CGFloat()
    var subtractLayerWidthValue = CGFloat()
    
    //MARK: View Touch Variables
    var pixelsPassedLeft = 0
    var pixelsPassedRight = 0
    
    //MARK: UI Element Variables
    let layer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red:0.01, green:0.6, blue:0.54, alpha:1.0).CGColor
        layer.opacity = 0.7
        return layer
    }()
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .Center
        timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 200.0)
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.text = "00:00"
        return timeLabel
    }()
    let leftArrowImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "LeftArrow2")
        return imageView
        
    }()
    let rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "RightArrow2")
        return imageView
        
    }()
    let topSettingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "SettingsIcon")
        return imageView
        
    }()
    let bottomResetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "ResetIcon")
        return imageView
        
    }()
    
    
    //MARK: Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.configureView()
        self.configureSubviews()
        self.configureConstraints()
        self.configureGesturesRecognizers()

    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.leftArrowImage.alpha = 0.0
        self.rightArrowImage.alpha = 0.0
        self.topSettingsImage.alpha = 0.0
        self.bottomResetImage.alpha = 0.0
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UIViewController Transitioning Delegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        zScaleVerticalAnimationController.reverse = false
        return zScaleVerticalAnimationController
    
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
   
        zScaleVerticalAnimationController.reverse = true
        return zScaleVerticalAnimationController
        
    }
    
    
    //MARK: View Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       self.showTimerFunctions()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       self.hideTimerFunctions()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let newPoint = touches.first!.locationInView(self.view)
        let prevPoint = touches.first!.previousLocationInView(self.view)
        
        if self.timer == nil
        {
            if (newPoint.x > prevPoint.x)
            {
                 //finger touch went right
               
                    ++self.pixelsPassedRight
                    if self.pixelsPassedRight > 3
                    {
                        ++self.secondsToCountdown
                        self.pixelsPassedRight = 0
                    }
                
               
                
            }
            else
            {
                //finger touch went left
                
                
                    ++self.pixelsPassedLeft
                    if self.pixelsPassedLeft > 3
                    {
                        if self.secondsToCountdown != 0
                        {
                            --self.secondsToCountdown
                        }
                        self.pixelsPassedLeft = 0
                    }
                
                
            }
        
//        if (newPoint.y > prevPoint.y)
//        {
//            //finger touch went downwards
//            ++self.pixelsPassedBottom
//            if self.pixelsPassedBottom > 10
//            {
//                self.resetTimer()
//                self.pixelsPassedBottom = 0
//            }
//        }
//        else
//        {
//           //finger touch went upwards
//            ++self.pixelsPassedTop
//            if self.pixelsPassedTop > 10
//            {
//                let vc = SettingsViewController()
//                vc.view.backgroundColor = UIColor.whiteColor()
//                vc.transitioningDelegate = self
//                self.presentViewController(vc, animated: true, completion: nil)
//                self.pixelsPassedTop = 0
//            }
//        }
 
            self.timerStaticValue = self.secondsToCountdown
            self.timeLabel.text = self.formatSeconds(Int(self.secondsToCountdown))
        
        }
    }
    
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?)
    {
        for item in presses
        {
            if item.type == .PlayPause || item.type == .Select
            {
                if self.timer == nil
                {
                    self.subtractLayerWidthValue = self.layer.frame.size.height/(self.secondsToCountdown - 1)
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
                }
            }
            
            if item.type == .Menu
            {
                self.timerFinished()
            }
        }
    }
    
    
    //MARK: Configuration
    
    private func configureView()
    {
        self.view.backgroundColor = UIColor(red:0.26, green:0.29, blue:0.33, alpha:1)
    }
    
    private func configureSubviews()
    {
        layer.frame = self.view.frame
        self.view.layer.addSublayer(layer)
        
        self.view.addSubview(self.timeLabel)
        
        self.view.addSubview(self.leftArrowImage)
        self.view.addSubview(self.rightArrowImage)
        self.view.addSubview(self.topSettingsImage)
        self.view.addSubview(self.bottomResetImage)
        self.leftArrowImage.alpha = 0.0
        self.rightArrowImage.alpha = 0.0
        self.topSettingsImage.alpha = 0.0
        self.bottomResetImage.alpha = 0.0
    }
    
    private func configureConstraints()
    {
        let viewDict = ["timeLabel": timeLabel, "leftArrowImage": leftArrowImage, "rightArrowImage": rightArrowImage, "topSettingsImage": self.topSettingsImage, "bottomResetImage": self.bottomResetImage]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[topSettingsImage(80)]-50-[timeLabel]-50-[bottomResetImage(80)]-50-|", options: [.AlignAllCenterX], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[leftArrowImage]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[rightArrowImage]-200-|", options: [], metrics: nil, views: viewDict))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-150-[leftArrowImage(50)]-500-[timeLabel]-500-[rightArrowImage(50)]-150-|", options: [], metrics: nil, views: viewDict))
        
        //        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-500-[topSettingsImage(200)]-500-|", options: [], metrics: nil, views: viewDict))
        
    }
    
    private func configureGesturesRecognizers()
    {
        let swipeGTop = UISwipeGestureRecognizer(target: self, action: "swipeUP")
        swipeGTop.direction = .Up
        self.view.addGestureRecognizer(swipeGTop)
        
        let swipeGBottom = UISwipeGestureRecognizer(target: self, action: "swipeDOWN")
        swipeGBottom.direction = .Down
        self.view.addGestureRecognizer(swipeGBottom)
        
//        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress")
//        longPress.minimumPressDuration = 1.0
//        self.view.addGestureRecognizer(longPress)
    }
    
    //MARK: Actions
    
    func swipeUP()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/2.3, self.view.frame.size.height/2.4)
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing = 100;
        flowLayout.minimumLineSpacing = 90;
        let vc: SettingsCollectionViewController = SettingsCollectionViewController(collectionViewLayout: flowLayout)
        vc.view.backgroundColor = UIColor.whiteColor()
        vc.transitioningDelegate = self
        self.presentViewController(vc, animated: true, completion: nil)
        self.hideTimerFunctions()
    }
    
    func swipeDOWN()
    {
        self.resetTimer()
        self.hideTimerFunctions()
    }

   
    //MARK: Timer Handling
    
    func updateTimer()
    {
        
        if self.secondsToCountdown != 0
        {
            print(self.layer.frame.size.height)
            self.secondsToCountdown =  self.secondsToCountdown - 1
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(1.0)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0, 0, 0, 0))
            self.layer.frame = CGRectMake(0, 0, self.layer.frame.size.width, self.layer.frame.size.height - self.subtractLayerWidthValue)
            CATransaction.commit()
            self.timeLabel.text = self.formatSeconds(Int(self.secondsToCountdown))
        }
        else
        {
            self.timerFinished()
        }
        
        
    }
    
    func formatSeconds(seconds: Int) -> String
    {
        let mins: Int = seconds / 60
        let secs: Int = seconds % 60
        
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func showTimerFunctions()
    {
        UIView.animateWithDuration(0.7) { () -> Void in
            self.leftArrowImage.alpha = 1.0
            self.rightArrowImage.alpha = 1.0
            self.topSettingsImage.alpha = 1.0
            self.bottomResetImage.alpha = 1.0
        }
        
    }
    
    func hideTimerFunctions()
    {
        UIView.animateWithDuration(0.7) { () -> Void in
            self.leftArrowImage.alpha = 0.0
            self.rightArrowImage.alpha = 0.0
            self.topSettingsImage.alpha = 0.0
            self.bottomResetImage.alpha = 0.0
        }
    }
    
    func timerFinished()
    {
        self.timer?.invalidate()
        self.timer = nil
        self.layer.frame = self.view.frame
        self.secondsToCountdown = timerStaticValue
        self.timeLabel.text =  self.formatSeconds(Int(self.secondsToCountdown))
        self.subtractLayerWidthValue = 0
        self.pixelsPassedRight = 0
        self.pixelsPassedLeft = 0
    }
    
    func resetTimer()
    {
        self.timer?.invalidate()
        self.timer = nil
        self.layer.frame = self.view.frame
        self.secondsToCountdown = 0
        self.timerStaticValue = 0
        self.timeLabel.text = self.formatSeconds(Int(self.secondsToCountdown))
        self.subtractLayerWidthValue = 0
        self.pixelsPassedRight = 0
        self.pixelsPassedLeft = 0
    }
}

