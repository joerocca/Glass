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
    //MARK: Constants
    private let secondsMin = CGFloat(0)
    private let secondsMax = CGFloat(600)
    
    //MARK: Properties
    private var timerSettings: TimerSettings
    private var timer: JRTimer
    fileprivate var subtractLayerHeightValue = CGFloat()
    fileprivate var pixelsPassedLeft = 0
    fileprivate var pixelsPassedRight = 0
    private var hideTimerDispatchWorkItem: DispatchWorkItem?
    private var locked: Bool = false {
        didSet {
            self.toggleLockInterface()
        }
    }
    
    //MARK: UI Element Properties
    fileprivate let zScaleVerticalAnimationController = ZScaleVerticalAnimationController()
    
    private lazy var swipeUpGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerViewController.swipeUpGestureAction(sender:)))
        swipeGestureRecognizer.direction = .up
        return swipeGestureRecognizer
    }()
    
    private lazy var swipeDownGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerViewController.swipeDownGestureAction(sender:)))
        swipeGestureRecognizer.direction = .down
        return swipeGestureRecognizer
    }()
    
    private lazy var lockGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TimerViewController.lockGestureAction(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        return tapGestureRecognizer
    }()
    
    fileprivate let timeIndicationlayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0.7
        return layer
    }()
    
    fileprivate let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0"
        return label
    }()
    
    private let leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LeftArrowIcon")
        imageView.alpha = 0.0
        return imageView
    }()
    
    private let rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "RightArrowIcon")
        imageView.alpha = 0.0
        return imageView
    }()
    
    private let topSettingsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SettingsIcon")
        imageView.alpha = 0.0
        return imageView
    }()
    
    private var bottomImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "UnlockIcon")
        imageView.alpha = 0.0
        return imageView
    }()
    
    init() {
        timer = JRTimer()
        timerSettings = TimerSettings.fetchTimerSettingsObject()
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
        self.view.addSubview(self.bottomImage)
        
        //Constraints
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints.append(self.timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        allConstraints.append(self.timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        
        allConstraints.append(self.leftArrowImage.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        allConstraints.append(self.leftArrowImage.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        allConstraints.append(self.leftArrowImage.heightAnchor.constraint(equalToConstant: 50))
        
        allConstraints.append(self.rightArrowImage.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        allConstraints.append(self.rightArrowImage.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        allConstraints.append(self.rightArrowImage.heightAnchor.constraint(equalToConstant: 50))
        
        allConstraints.append(self.topSettingsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        allConstraints.append(self.topSettingsImage.layoutMarginsGuide.topAnchor.constraint(equalTo: view.topAnchor))
        allConstraints.append(self.topSettingsImage.widthAnchor.constraint(equalToConstant: 80))
        
        allConstraints.append(self.bottomImage.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        allConstraints.append(self.bottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        allConstraints.append(self.bottomImage.widthAnchor.constraint(equalToConstant: 80))
        
        NSLayoutConstraint.activate(allConstraints)
        
        //MARK: Gesture Recognizers
        self.view.addGestureRecognizer(self.swipeUpGestureRecognizer)
        self.view.addGestureRecognizer(self.swipeDownGestureRecognizer)
        self.view.addGestureRecognizer(self.lockGestureRecognizer)
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
        self.showTimerFunctions(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showTimerFunctions(false)
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let latestTouch = touches.first else {
            return
        }
        let newPoint = latestTouch.location(in: self.view)
        let prevPoint = latestTouch.previousLocation(in: self.view)
        
        if self.timer.state == .stopped && !self.locked {
            var seconds = CGFloat(self.timer.totalSeconds)
            if (newPoint.x > prevPoint.x) {
                //Slide Right
                self.pixelsPassedRight += 1
                if self.pixelsPassedRight > self.timerSettings.scrubSpeed.speed {
                    if seconds < self.secondsMax {
                        seconds += 1
                    }
                    self.pixelsPassedRight = 0
                }
            } else {
                //Slide Left
                self.pixelsPassedLeft += 1
                if self.pixelsPassedLeft > self.timerSettings.scrubSpeed.speed {
                    if seconds > self.secondsMin {
                        seconds -= 1
                    }
                    self.pixelsPassedLeft = 0
                }
            }
            
            self.timer.setTimer(seconds: TimeInterval(seconds), totalSeconds: TimeInterval(seconds))
            self.timeLabel.text = self.timer.string
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            switch press.type {
                case .playPause:
                    guard self.timer.totalSeconds > 0 else {
                        return
                    }
                    switch self.timer.state {
                        case .stopped, .paused:
                            self.subtractLayerHeightValue = self.timeIndicationlayer.frame.size.height/CGFloat(self.timer.seconds - (self.timer.totalSeconds == 1 ? 0 : 1))
                            self.timer.startTimer()
                            self.enableTimerFunctions(false)
                        case .ticking:
                            self.timer.pauseTimer()
                    }
                case .menu:
                    self.timer.pauseTimer()
                default:
                    break
            }
        }
        super.pressesBegan(presses, with: event)
    }
    
    //MARK: Configuration
    fileprivate func reloadVCForSettings() {
        //Theme
        self.timerSettings = TimerSettings.fetchTimerSettingsObject()
        
        self.view.backgroundColor = self.timerSettings.theme.backgroundColor
        self.timeIndicationlayer.backgroundColor = self.timerSettings.theme.foregroundColor
        self.timeLabel.font = self.timerSettings.font
    }

    //MARK: Actions
    @objc private func swipeUpGestureAction(sender: UISwipeGestureRecognizer) {
        let interitemSpacing = CGFloat(120)
        let lineSpacing = CGFloat(90)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width/2 - interitemSpacing, height: self.view.frame.size.height/2 - lineSpacing)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = interitemSpacing;
        flowLayout.minimumLineSpacing = lineSpacing;
        let settingsVC: SettingsCollectionViewController = SettingsCollectionViewController(collectionViewLayout: flowLayout)
        settingsVC.view.backgroundColor = UIColor.white
        settingsVC.transitioningDelegate = self
        self.present(settingsVC, animated: true, completion: nil)
        self.showTimerFunctions(false)
    }
    
    @objc private func swipeDownGestureAction(sender: UISwipeGestureRecognizer) {
        switch self.timer.state {
            case .ticking, .paused:
                self.timer.stopTimer()
                self.timeIndicationlayer.frame = self.view.frame
                self.timeLabel.text = self.timer.string
                self.subtractLayerHeightValue = 0
                self.pixelsPassedRight = 0
                self.pixelsPassedLeft = 0
                self.showTimerFunctions(false)
                self.enableTimerFunctions(true)
            default:
                return
        }
    }
    
    @objc private func lockGestureAction(sender: UITapGestureRecognizer) {
        if self.timer.state == .stopped {
            self.locked = !self.locked
        }
    }
    
    //MARK: Helpers
    private func showTimerFunctions(_ show: Bool) {
        if let hideTimerDispatchWorkItem = self.hideTimerDispatchWorkItem {
            hideTimerDispatchWorkItem.cancel()
        }
        if show {
            UIView.animate(withDuration: 0.7, animations: { () -> Void in
                self.leftArrowImage.alpha = 1.0
                self.rightArrowImage.alpha = 1.0
                self.topSettingsImage.alpha = 1.0
                self.bottomImage.alpha = 1.0
            })
        } else {
            self.hideTimerDispatchWorkItem = DispatchWorkItem {
                UIView.animate(withDuration: 0.7, animations: { () -> Void in
                    self.leftArrowImage.alpha = 0.0
                    self.rightArrowImage.alpha = 0.0
                    self.topSettingsImage.alpha = 0.0
                    self.bottomImage.alpha = 0.0
                })
            }
            guard let hideTimerDispatchWorkItem = self.hideTimerDispatchWorkItem else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: hideTimerDispatchWorkItem)
        }
    }
    
    fileprivate func enableTimerFunctions(_ enable: Bool) {
        if enable {
            self.toggleLockInterface()
            self.topSettingsImage.isHidden = false
            self.swipeUpGestureRecognizer.isEnabled = true
        } else {
            self.bottomImage.image = UIImage(named: "ResetIcon")
            self.leftArrowImage.isHidden = true
            self.rightArrowImage.isHidden = true
            self.topSettingsImage.isHidden = true
            self.swipeUpGestureRecognizer.isEnabled = false
        }
    }

    private func toggleLockInterface() {
        if self.locked {
            bottomImage.image = UIImage(named: "LockIcon")
            self.leftArrowImage.isHidden = true
            self.rightArrowImage.isHidden = true
        } else {
            bottomImage.image = UIImage(named: "UnlockIcon")
            self.leftArrowImage.isHidden = false
            self.rightArrowImage.isHidden = false
        }
    }
    
    fileprivate func playBuzzer() {
        var soundID: SystemSoundID = 0
        let mainBundle: CFBundle = CFBundleGetMainBundle()
        let soundName = self.timerSettings.sound.name as CFString!
        let soundFileType = self.timerSettings.sound.fileType as CFString!
        if let ref: CFURL = CFBundleCopyResourceURL(mainBundle, soundName, soundFileType, nil) {
            print("Here is your ref: \(ref)")
            AudioServicesCreateSystemSoundID(ref, &soundID)
            AudioServicesPlaySystemSound(soundID)
        } else {
            print("Could not find sound file")
        }
    }
    
    //MARK: Extras
    fileprivate func animateTimeIndicationLayer(closure: () -> Void) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        closure()
        CATransaction.commit()
    }
}

extension TimerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.zScaleVerticalAnimationController.reverse = false
        return self.zScaleVerticalAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.zScaleVerticalAnimationController.reverse = true
        return self.zScaleVerticalAnimationController
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
        self.enableTimerFunctions(true)
    }
}
