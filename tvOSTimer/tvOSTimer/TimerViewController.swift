//
//  ViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit
import AudioToolbox

class TimerViewController: UIViewController {
    
    //MARK: Properties
    var timerSettings: TimerSettings?
    var timer: Timer?
    var secondsToCountdown = CGFloat()
    var timerStaticValue = CGFloat()
    var subtractLayerWidthValue = CGFloat()
    var pixelsPassedLeft = 0
    var pixelsPassedRight = 0
    
    //MARK: UI Element Properties
    let zScaleVerticalAnimationController = ZScaleVerticalAnimationController()
    
    let layer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0.7
        return layer
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .center
//        timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 200.0)
        timeLabel.textColor = UIColor.white
        timeLabel.text = "00:00"
        return timeLabel
    }()
    
    let leftArrowImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LeftArrow2")
        return imageView
        
    }()
    
    let rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RightArrow2")
        return imageView
        
    }()
    
    let topSettingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SettingsIcon")
        return imageView
        
    }()
    
    let bottomResetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ResetIcon")
        return imageView
        
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Subviews
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
        //Constraints
        let viewDict = ["timeLabel": timeLabel, "leftArrowImage": leftArrowImage, "rightArrowImage": rightArrowImage, "topSettingsImage": self.topSettingsImage, "bottomResetImage": self.bottomResetImage]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[topSettingsImage(80)]-50-[timeLabel]-50-[bottomResetImage(80)]-50-|", options: [.alignAllCenterX], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[leftArrowImage]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[rightArrowImage]-200-|", options: [], metrics: nil, views: viewDict))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-150-[leftArrowImage(50)]-100-[timeLabel]-100-[rightArrowImage(50)]-150-|", options: [], metrics: nil, views: viewDict))
        //Other
        let swipeGTop = UISwipeGestureRecognizer(target: self, action: #selector(TimerViewController.swipeUP))
        swipeGTop.direction = .up
        self.view.addGestureRecognizer(swipeGTop)
        
        let swipeGBottom = UISwipeGestureRecognizer(target: self, action: #selector(TimerViewController.swipeDOWN))
        swipeGBottom.direction = .down
        self.view.addGestureRecognizer(swipeGBottom)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.leftArrowImage.alpha = 0.0
        self.rightArrowImage.alpha = 0.0
        self.topSettingsImage.alpha = 0.0
        self.bottomResetImage.alpha = 0.0
    
        self.configureAllSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Touch Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.showTimerFunctions()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.hideTimerFunctions()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = touches.first!.location(in: self.view)
        let prevPoint = touches.first!.previousLocation(in: self.view)
        
        if self.timer == nil {
            if (newPoint.x > prevPoint.x) {
                //finger touch went right
                self.pixelsPassedRight += 1
                if self.pixelsPassedRight > self.timerSettings!.scrubSpeed.speed
                {
                    self.secondsToCountdown += 1
                    self.pixelsPassedRight = 0
                }
            } else {
                //finger touch went left
                self.pixelsPassedLeft += 1
                if self.pixelsPassedLeft > self.timerSettings!.scrubSpeed.speed
                {
                    if self.secondsToCountdown != 0
                    {
                        self.secondsToCountdown -= 1
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
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            if item.type == .playPause || item.type == .select {
                if self.timer == nil {
                    self.subtractLayerWidthValue = self.layer.frame.size.height/(self.secondsToCountdown - 1)
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerViewController.updateTimer), userInfo: nil, repeats: true)
                }
            }
            
            if item.type == .menu {
                self.timerFinished()
            }
        }
    }
    
    //MARK: Configuration
    fileprivate func configureAllSettings() {
        //Theme
        let timerSettingsData = UserDefaults.standard.data(forKey: SettingsConstants.timerSettingsKey)!
        let timerSettings = NSKeyedUnarchiver.unarchiveObject(with: timerSettingsData) as! TimerSettings
        
        self.timerSettings = timerSettings
        
        self.view.backgroundColor = self.timerSettings!.theme.backgroundColor
        self.layer.backgroundColor = self.timerSettings!.theme.foregroundColor
        self.timeLabel.font = self.timerSettings!.font
    }
    
    //MARK: Actions
    func swipeUP() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width/2.3, height: self.view.frame.size.height/2.4)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 100;
        flowLayout.minimumLineSpacing = 90;
        let vc: SettingsCollectionViewController = SettingsCollectionViewController(collectionViewLayout: flowLayout)
        vc.view.backgroundColor = UIColor.white
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
        self.hideTimerFunctions()
    }
    
    func swipeDOWN() {
        self.resetTimer()
        self.hideTimerFunctions()
    }
   
    //MARK: Timer Handling
    func updateTimer() {
        if self.secondsToCountdown > 1 {
            print(self.layer.frame.size.height)
            self.secondsToCountdown = self.secondsToCountdown - 1
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(1.0)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0, 0, 0, 0))
            self.layer.frame = CGRect(x: 0, y: 0, width: self.layer.frame.size.width, height: self.layer.frame.size.height - self.subtractLayerWidthValue)
            CATransaction.commit()
            self.timeLabel.text = self.formatSeconds(Int(self.secondsToCountdown))
        } else {
            self.playBuzzerSound()
            self.timerFinished()
        }
    }
    
    func formatSeconds(_ seconds: Int) -> String {
        let mins: Int = seconds / 60
        let secs: Int = seconds % 60
        
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func showTimerFunctions() {
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
            self.leftArrowImage.alpha = 1.0
            self.rightArrowImage.alpha = 1.0
            self.topSettingsImage.alpha = 1.0
            self.bottomResetImage.alpha = 1.0
        })
    }
    
    func hideTimerFunctions() {
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
            self.leftArrowImage.alpha = 0.0
            self.rightArrowImage.alpha = 0.0
            self.topSettingsImage.alpha = 0.0
            self.bottomResetImage.alpha = 0.0
        }) 
    }
    
    func timerFinished() {
        self.timer?.invalidate()
        self.timer = nil
        self.layer.frame = self.view.frame
        self.secondsToCountdown = timerStaticValue
        self.timeLabel.text =  self.formatSeconds(Int(self.secondsToCountdown))
        self.subtractLayerWidthValue = 0
        self.pixelsPassedRight = 0
        self.pixelsPassedLeft = 0
    }
    
    func resetTimer() {
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
    
    func playBuzzerSound() {
        var soundID: SystemSoundID = 0
        let mainBundle: CFBundle = CFBundleGetMainBundle()
        let soundName = self.timerSettings!.sound.name as CFString!
        let soundFileType = self.timerSettings!.sound.fileType as CFString!
        if let ref: CFURL = CFBundleCopyResourceURL(mainBundle, soundName, soundFileType, nil) {
            print("Here is your ref: \(ref)")
            AudioServicesCreateSystemSoundID(ref, &soundID)
            AudioServicesPlaySystemSound(soundID)
        } else {
            print("Could not find sound file")
        }
    }
}

extension TimerViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        zScaleVerticalAnimationController.reverse = false
        return zScaleVerticalAnimationController
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        zScaleVerticalAnimationController.reverse = true
        return zScaleVerticalAnimationController
    }
}
