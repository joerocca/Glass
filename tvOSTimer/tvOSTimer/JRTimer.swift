//
//  Timer.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/14/17.
//  Copyright © 2017 Joe Rocca. All rights reserved.
//

import Foundation

protocol JRTimerDelegate: class {
    func timerDidTick(timer: JRTimer)
    func timerCompleted(timer: JRTimer)
}

class JRTimer: NSObject {
    
    //MARK: Properties
    weak var delegate: JRTimerDelegate?
    private (set) var seconds = TimeInterval(0)
    private (set) var totalSeconds = TimeInterval(0)
    private var timer: Timer?
    var isOn: Bool {
        get {
            return self.timer != nil
        }
    }
    var string: String {
        get {
            let totalSeconds = Int(self.seconds)
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
            var hoursString = ""
            if hours > 0 {
                hoursString = "\(hours):"
            }
            
            var minutesString = ""
            if minutes < 10 {
                minutesString = "0\(minutes):"
            } else {
                minutesString = "\(minutes):"
            }
            
            var secondsString = ""
            if seconds < 10 {
                secondsString = "0\(seconds)"
            } else {
                secondsString = "\(seconds)"
            }
            
            return hoursString + minutesString + secondsString
        }
    }
    
    //MARK: Timer Methods
    func setTimer(seconds: TimeInterval, totalSeconds: TimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    func startTimer() {
        if !isOn && self.totalSeconds > 0 {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(JRTimer.tick), userInfo: nil, repeats: true)
        }
    }
    
    func pauseTimer() {
        if isOn {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func stopTimer() {
        if isOn {
            self.timer?.invalidate()
            self.timer = nil
            self.seconds = self.totalSeconds
        }
    }
    
    func resetTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.seconds = TimeInterval(0)
        self.totalSeconds = TimeInterval(0)
    }
    
    func tick() {
        self.seconds -= 1
        self.delegate!.timerDidTick(timer: self)
        if seconds <= 0 {
            self.pauseTimer()
            self.seconds = self.totalSeconds
            self.delegate!.timerCompleted(timer: self)
        }
    }
}
