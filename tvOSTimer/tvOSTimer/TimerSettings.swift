//
//  TimerSettings.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation
import UIKit

class TimerSettings: NSObject, NSCoding {
    
    var theme: Theme
    var font: UIFont
    var sound: Sound
    var scrubSpeed: ScrubSpeed
    
    //MARK: Initialization
    
    init(theme: Theme, font: UIFont, sound: Sound, scrubSpeed: ScrubSpeed)
    {
        self.theme = theme
        self.font = font
        self.sound = sound
        self.scrubSpeed = scrubSpeed
    }
    
    
    //MARK: NSCoding Functions
    
    private let THEME_KEY = "theme"
    private let FONT_KEY = "font"
    private let SOUND_KEY = "sound"
    private let SCRUB_SPEED_KEY = "scrub_speed"
    
    required init(coder decoder: NSCoder)
    {
        self.theme = decoder.decodeObjectForKey(THEME_KEY) as! Theme
        self.font = decoder.decodeObjectForKey(FONT_KEY) as! UIFont
        self.sound = decoder.decodeObjectForKey(SOUND_KEY) as! Sound
        self.scrubSpeed = decoder.decodeObjectForKey(SCRUB_SPEED_KEY) as! ScrubSpeed
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.theme, forKey: THEME_KEY)
        coder.encodeObject(self.font, forKey: FONT_KEY)
        coder.encodeObject(self.sound, forKey: SOUND_KEY)
        coder.encodeObject(self.scrubSpeed, forKey: SCRUB_SPEED_KEY)
    }
    
    
    //MARK: Update Functions
    
    class func setTheme(theme: Theme)
    {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.theme = theme
        self.setNewTimerSettingsObject(themeSettings)
    }
    
    class func setFont(font: UIFont)
    {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.font = font
        self.setNewTimerSettingsObject(themeSettings)
    }
    
    class func setSound(sound: Sound)
    {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.sound = sound
        self.setNewTimerSettingsObject(themeSettings)
    }
    
    class func setScrubSpeed(scrubSpeed: ScrubSpeed)
    {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.scrubSpeed = scrubSpeed
        self.setNewTimerSettingsObject(themeSettings)
    }
    
    class func setNewTimerSettingsObject(timerSettings: TimerSettings)
    {
        let newTimerSettingsData = NSKeyedArchiver.archivedDataWithRootObject(timerSettings)
        NSUserDefaults.standardUserDefaults().setObject(newTimerSettingsData, forKey: SettingsConstants.timerSettingsKey)
        
    }
    
    
    //MARK: Fetch Timer Settings Object
    
    class func fetchTimerSettingsObject() -> TimerSettings
    {
        let timerSettingsData = NSUserDefaults.standardUserDefaults().dataForKey(SettingsConstants.timerSettingsKey)!
        let timerSettings = NSKeyedUnarchiver.unarchiveObjectWithData(timerSettingsData) as! TimerSettings
        
        return timerSettings
    }
    
  
    //MARK: Set Default Object
    
    class func setDefaultObject()
    {
        let timerSettings = TimerSettings(theme: SettingsConstants.ThemeConstants.themeOptions[0], font: UIFont(name: "HelveticaNeue-UltraLight", size: 200.0)!, sound: Sound(name: "Buzzer", fileType: "mp3"), scrubSpeed: ScrubSpeed(name: "Normal", speed: 3))
        let timerSettingsData = NSKeyedArchiver.archivedDataWithRootObject(timerSettings)
        NSUserDefaults.standardUserDefaults().setObject(timerSettingsData, forKey: SettingsConstants.timerSettingsKey)
    }
    
}