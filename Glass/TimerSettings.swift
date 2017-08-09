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
    
    //MARK: Properties
    var theme: Theme
    var font: UIFont
    var sound: Sound
    var scrubSpeed: ScrubSpeed
    
    //MARK: Initialization
    init(theme: Theme, font: UIFont, sound: Sound, scrubSpeed: ScrubSpeed) {
        self.theme = theme
        self.font = font
        self.sound = sound
        self.scrubSpeed = scrubSpeed
    }

    //MARK: Update Functions
    class func setTheme(theme: Theme) {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.theme = theme
        self.setNewTimerSettingsObject(timerSettings: themeSettings)
    }
    
    class func setFont(font: UIFont) {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.font = font
        self.setNewTimerSettingsObject(timerSettings: themeSettings)
    }
    
    class func setSound(sound: Sound) {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.sound = sound
        self.setNewTimerSettingsObject(timerSettings: themeSettings)
    }
    
    class func setScrubSpeed(scrubSpeed: ScrubSpeed) {
        let themeSettings = self.fetchTimerSettingsObject()
        themeSettings.scrubSpeed = scrubSpeed
        self.setNewTimerSettingsObject(timerSettings: themeSettings)
    }
    
    class func setNewTimerSettingsObject(timerSettings: TimerSettings) {
        let newTimerSettingsData = NSKeyedArchiver.archivedData(withRootObject: timerSettings)
        UserDefaults.standard.set(newTimerSettingsData, forKey: SettingsConstants.timerSettingsKey)
    }
    
    //MARK: Fetch Timer Settings Object
    class func fetchTimerSettingsObject() -> TimerSettings {
        guard let timerSettingsData = UserDefaults.standard.data(forKey: SettingsConstants.timerSettingsKey),
            let timerSettings = NSKeyedUnarchiver.unarchiveObject(with: timerSettingsData) as? TimerSettings else {
                fatalError("Could not find TimeSettings object.")
        }
        return timerSettings
    }
    
    //MARK: Set Default Object
    class func setDefaultObject() {
        let timerSettings = TimerSettings(theme: SettingsConstants.ThemeConstants.themeOptions[2], font: SettingsConstants.FontConstants.fontOptions[11], sound: SettingsConstants.SoundConstants.soundOptions[2], scrubSpeed: SettingsConstants.ScrubSpeedConstants.scrubSpeedOptions[1])
        let timerSettingsData = NSKeyedArchiver.archivedData(withRootObject: timerSettings)
        UserDefaults.standard.set(timerSettingsData, forKey: SettingsConstants.timerSettingsKey)
    }
    
    //MARK: NSCoding
    fileprivate let THEME_KEY = "theme"
    fileprivate let FONT_KEY = "font"
    fileprivate let SOUND_KEY = "sound"
    fileprivate let SCRUB_SPEED_KEY = "scrub_speed"
    
    required init(coder decoder: NSCoder) {
        self.theme = decoder.decodeObject(forKey: THEME_KEY) as! Theme
        self.font = decoder.decodeObject(forKey: FONT_KEY) as! UIFont
        self.sound = decoder.decodeObject(forKey: SOUND_KEY) as! Sound
        self.scrubSpeed = decoder.decodeObject(forKey: SCRUB_SPEED_KEY) as! ScrubSpeed
        
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.theme, forKey: THEME_KEY)
        coder.encode(self.font, forKey: FONT_KEY)
        coder.encode(self.sound, forKey: SOUND_KEY)
        coder.encode(self.scrubSpeed, forKey: SCRUB_SPEED_KEY)
    }
}
