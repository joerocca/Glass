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
    
    //MARK: Initialization
    
    init(theme: Theme, font: UIFont)
    {
        self.theme = theme
        self.font = font
    }
    
    
    //MARK: NSCoding Functions
    
    required init(coder decoder: NSCoder)
    {
        self.theme = decoder.decodeObjectForKey("theme") as! Theme
        self.font = decoder.decodeObjectForKey("font") as! UIFont
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.theme, forKey: "theme")
        coder.encodeObject(self.font, forKey: "font")
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
        let timerSettings = TimerSettings(theme: SettingsConstants.ThemeConstants.themeOptions[0], font: UIFont(name: "HelveticaNeue-UltraLight", size: 200.0)!)
        let timerSettingsData = NSKeyedArchiver.archivedDataWithRootObject(timerSettings)
        NSUserDefaults.standardUserDefaults().setObject(timerSettingsData, forKey: SettingsConstants.timerSettingsKey)
    }
    
}