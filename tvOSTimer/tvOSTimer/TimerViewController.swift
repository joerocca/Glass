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
    var timer: JRTimer?
    var secondsToCountdown = CGFloat()
    var subtractLayerHeightValue = CGFloat()
    var pixelsPassedLeft = 0
    var pixelsPassedRight = 0
    var swipeUpGestureRecognizer: UISwipeGestureRecognizer?
    var swipeDownGestureRecognizer: UISwipeGestureRecognizer?
    
    //MARK: UI Element Properties
    let zScaleVerticalAnimationController = ZScaleVerticalAnimationController()
    
    let timeIndicationlayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0.7
        return layer
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .center
        timeLabel.textColor = UIColor.white
        timeLabel.text = "00:00"
        return timeLabel
    }()
    
    let leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LeftArrow")
        imageView.alpha = 0.0
        return imageView
    }()
    
    let rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RightArrow")
        imageView.alpha = 0.0
        return imageView
    }()
    
    let topSettingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SettingsIcon")
        imageView.alpha = 0.0
        return imageView
    }()
    
    let bottomResetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ResetIcon")
        imageView.alpha = 0.0
        return imageView
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Subviews
        self.timeIndicationlayer.frame = self.view.frame
        self.view.layer.addSublayer(self.timeIndicationlayer)
        
        self.view.addSubview(self.timeLabel)
        
        self.view.addSubview(self.leftArrowImage)
        self.view.addSubview(self.rightArrowImage)
        self.view.addSubview(self.topSettingsImage)
        self.view.addSubview(self.bottomResetImage)
        //Constraints
        let viewDict = ["timeLabel": timeLabel, "leftArrowImage": leftArrowImage, "rightArrowImage": rightArrowImage, "topSettingsImage": self.topSettingsImage, "bottomResetImage": self.bottomResetImage]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[topSettingsImage(80)]-50-[timeLabel]-50-[bottomResetImage(80)]-50-|", options: [.alignAllCenterX], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[leftArrowImage]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[rightArrowImage]-200-|", options: [], metrics: nil, views: viewDict))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-150-[leftArrowImage(50)]-100-[timeLabel]-100-[rightArrowImage(50)]-150-|", options: [], metrics: nil, views: viewDict))
        //Other
        self.timer = JRTimer()
        self.timer!.delegate = self
        
        self.swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerViewController.swipeUp))
        swipeUpGestureRecognizer!.direction = .up
        self.view.addGestureRecognizer(swipeUpGestureRecognizer!)
        
        self.swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerViewController.swipeDown))
        swipeDownGestureRecognizer!.direction = .down
        self.view.addGestureRecognizer(swipeDownGestureRecognizer!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadVCForSettings()
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
        
        if !self.timer!.isOn {
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
            
            self.timer!.setTimer(seconds: TimeInterval(self.secondsToCountdown), totalSeconds: TimeInterval(self.secondsToCountdown))
            self.timeLabel.text = self.timer!.string
        }
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            switch press.type {
                case .playPause:
                    if !self.timer!.isOn && self.timer!.totalSeconds > 0 {
                        self.subtractLayerHeightValue = self.timeIndicationlayer.frame.size.height/CGFloat(self.timer!.seconds - 1)
                        self.timer!.startTimer()
                        self.disableTimerFunctions()
                    } else if self.timer!.isOn && self.timer!.totalSeconds > 0 {
                        self.timer!.pauseTimer()
                    }
                case .select:
                    break
                case .menu:
                    self.timer!.stopTimer()
                default: break
            }
        }
    }
    
    //MARK: Configuration
    fileprivate func reloadVCForSettings() {
        //Theme
        let timerSettingsData = UserDefaults.standard.data(forKey: SettingsConstants.timerSettingsKey)!
        let timerSettings = NSKeyedUnarchiver.unarchiveObject(with: timerSettingsData) as! TimerSettings
        
        self.timerSettings = timerSettings
        
        self.view.backgroundColor = self.timerSettings!.theme.backgroundColor
        self.timeIndicationlayer.backgroundColor = self.timerSettings!.theme.foregroundColor
        self.timeLabel.font = self.timerSettings!.font
    }
    
    //MARK: Actions
    func swipeUp() {
        let interitemSpacing = CGFloat(120)
        let lineSpacing = CGFloat(90)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width/2 - interitemSpacing, height: self.view.frame.size.height/2 - lineSpacing)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = interitemSpacing;
        flowLayout.minimumLineSpacing = lineSpacing;
        let vc: SettingsCollectionViewController = SettingsCollectionViewController(collectionViewLayout: flowLayout)
        vc.view.backgroundColor = UIColor.white
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
        self.hideTimerFunctions()
    }
    
    func swipeDown() {
        if self.timer!.isOn {
            self.timer!.stopTimer()
            self.timeIndicationlayer.frame = self.view.frame
            self.timeLabel.text = self.timer!.string
            self.subtractLayerHeightValue = 0
            self.pixelsPassedRight = 0
            self.pixelsPassedLeft = 0
            self.hideTimerFunctions()
            self.enableTimerFunctions()
        } else {
            self.timer!.resetTimer()
            self.timeLabel.text = self.timer!.string
            self.secondsToCountdown = 0
            self.pixelsPassedRight = 0
            self.pixelsPassedLeft = 0
            self.hideTimerFunctions()
        }
    }
    
    //MARK: Helpers
    func showTimerFunctions() {
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
            self.leftArrowImage.alpha = 1.0
            self.rightArrowImage.alpha = 1.0
            self.topSettingsImage.alpha = 1.0
            self.bottomResetImage.alpha = 1.0
        })
    }
    
    func hideTimerFunctions() {
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            self.leftArrowImage.alpha = 0.0
            self.rightArrowImage.alpha = 0.0
            self.topSettingsImage.alpha = 0.0
            self.bottomResetImage.alpha = 0.0
        }) 
    }
    
    func enableTimerFunctions() {
        self.leftArrowImage.isHidden = false
        self.rightArrowImage.isHidden = false
        self.topSettingsImage.isHidden = false
        self.swipeUpGestureRecognizer!.isEnabled = true
    }
    
    func disableTimerFunctions() {
        self.leftArrowImage.isHidden = true
        self.rightArrowImage.isHidden = true
        self.topSettingsImage.isHidden = true
        self.swipeUpGestureRecognizer!.isEnabled = false
    }
    
    func playBuzzer() {
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

extension TimerViewController: JRTimerDelegate {
    
    func timerDidTick(timer: JRTimer) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0, 0, 0, 0))
        self.timeIndicationlayer.frame = CGRect(x: 0, y: 0, width: self.timeIndicationlayer.frame.size.width, height: self.timeIndicationlayer.frame.size.height - self.subtractLayerHeightValue)
        CATransaction.commit()
        self.timeLabel.text = timer.string
    }
    
    func timerCompleted(timer: JRTimer) {
        self.playBuzzer()
        self.timeIndicationlayer.frame = self.view.frame
        self.timeLabel.text = timer.string
        self.subtractLayerHeightValue = 0
        self.pixelsPassedRight = 0
        self.pixelsPassedLeft = 0
        self.enableTimerFunctions()
    }
}
