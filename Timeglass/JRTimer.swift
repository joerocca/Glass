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
    //MARK: Enums
    enum State {
        case ticking
        case paused
        case stopped
    }
    
    //MARK: Properties
    weak var delegate: JRTimerDelegate?
    private (set) var seconds = TimeInterval(0)
    private (set) var totalSeconds = TimeInterval(0)
    private var timer: Timer?
    var state: State = .stopped
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
            if minutes > 0 {
                minutesString = "\(minutes):"
            }
            
            var secondsString = ""
            if minutes > 0 && seconds < 10 {
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
        if (self.state == .stopped || self.state == .paused) && self.totalSeconds > 0 {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(JRTimer.tick), userInfo: nil, repeats: true)
            self.state = .ticking
        }
    }
    
    func pauseTimer() {
        if self.state == .ticking {
            self.timer?.invalidate()
            self.timer = nil
            self.state = .paused
        }
    }
    
    func stopTimer() {
        if self.state == .ticking || self.state == .paused {
            self.timer?.invalidate()
            self.timer = nil
            self.seconds = self.totalSeconds
            self.state = .stopped
        }
    }
    
    func resetTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.seconds = TimeInterval(0)
        self.totalSeconds = TimeInterval(0)
        self.state = .stopped
    }
    
    func tick() {
        self.seconds -= 1
        self.delegate!.timerDidTick(timer: self)
        if seconds <= 0 {
            self.stopTimer()
            self.delegate!.timerCompleted(timer: self)
        }
    }
}
