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
    var timer: JRTimer
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
    
    init() {
        timer = JRTimer()
        super.init(nibName: nil, bundle: nil)
        timer.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        leftArrowImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        leftArrowImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftArrowImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        rightArrowImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rightArrowImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightArrowImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topSettingsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topSettingsImage.layoutMarginsGuide.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topSettingsImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        bottomResetImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomResetImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomResetImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
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
        guard let latestTouch = touches.first else {
            return
        }
        let newPoint = latestTouch.location(in: self.view)
        let prevPoint = latestTouch.previousLocation(in: self.view)
        
        if self.timer.state == .stopped {
            var seconds = CGFloat(self.timer.totalSeconds)
            if (newPoint.x > prevPoint.x) {
                //Slide Right
                self.pixelsPassedRight += 1
                if self.pixelsPassedRight > self.timerSettings!.scrubSpeed.speed {
                    seconds += 1
                    self.pixelsPassedRight = 0
                }
            } else {
                //Slide Left
                self.pixelsPassedLeft += 1
                if self.pixelsPassedLeft > self.timerSettings!.scrubSpeed.speed {
                    if seconds > 0 {
                        seconds -= 1
                    }
                    self.pixelsPassedLeft = 0
                }
            }
            
            self.timer.setTimer(seconds: TimeInterval(seconds), totalSeconds: TimeInterval(seconds))
            self.timeLabel.text = self.timer.string
        }
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            switch press.type {
                case .playPause:
                    if (self.timer.state == .stopped || self.timer.state == .paused) && self.timer.totalSeconds > 0 {
                        self.subtractLayerHeightValue = self.timeIndicationlayer.frame.size.height/CGFloat(self.timer.seconds - (self.timer.totalSeconds == 1 ? 0 : 1))
                        self.timer.startTimer()
                        self.disableTimerFunctions()
                    } else if self.timer.state == .ticking && self.timer.totalSeconds > 0 {
                        self.timer.pauseTimer()
                    }
                case .select:
                    break
                case .menu:
                    self.timer.pauseTimer()
                    super.pressesBegan(presses, with: event)
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
        switch self.timer.state {
            case .ticking, .paused:
                self.timer.stopTimer()
                self.timeIndicationlayer.frame = self.view.frame
                self.timeLabel.text = self.timer.string
                self.subtractLayerHeightValue = 0
                self.pixelsPassedRight = 0
                self.pixelsPassedLeft = 0
                self.hideTimerFunctions()
                self.enableTimerFunctions()
            default:
                self.timer.resetTimer()
                self.timeLabel.text = self.timer.string
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
    
    //MARK: Extras
    func animateTimeIndicationLayer(closure: () -> Void) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        closure()
        CATransaction.commit()
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
        self.animateTimeIndicationLayer {
            self.timeIndicationlayer.frame = CGRect(x: 0, y: 0, width: self.timeIndicationlayer.frame.size.width, height: self.timeIndicationlayer.frame.size.height - self.subtractLayerHeightValue)
        }
        self.timeLabel.text = timer.string
    }
    
    func timerCompleted(timer: JRTimer) {
        self.playBuzzer()
        self.animateTimeIndicationLayer {
            self.timeIndicationlayer.frame = self.view.frame
        }
        self.timeLabel.text = timer.string
        self.subtractLayerHeightValue = 0
        self.pixelsPassedRight = 0
        self.pixelsPassedLeft = 0
        self.enableTimerFunctions()
    }
}
