//
//  SettingsConstants.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation
import UIKit

struct SettingsConstants {
    static let timerSettingsKey = "SETTINGS_KEY"
    
    //MARK: Theme Constants
    struct ThemeConstants {
        static let themeOptions = [Theme(name: "Cool Guy", imageName: "CoolGuyThemeImage", backgroundColor: UIColor(red:0.26, green:0.29, blue:0.33, alpha:1), foregroundColor: UIColor(red:0.01, green:0.6, blue:0.54, alpha:1.0).cgColor),
                                   Theme(name: "Sunshine", imageName: "SunshineThemeImage", backgroundColor: UIColor.yellow, foregroundColor: UIColor.orange.cgColor)]
    }
    
    //MARK: Font Constants
    struct FontConstants {
        static let fontOptions : [String] = {
            var allFontOptions = [String]()
            allFontOptions.append(contentsOf: UIFont.familyNames)
            allFontOptions.sort()
            return allFontOptions
        }()
    }
    
    
    //MARK: Sound Constants
    struct SoundConstants {
        static let soundOptions = [Sound(name: "Buzzer", fileType: "mp3"),
                                   Sound(name: "Scream", fileType: "mp3"),
                                   Sound(name: "AHH", fileType: "mp3")]
    }
    
    //MARK: Scrub Speed Constants
    struct ScrubSpeedConstants {
        static let scrubSpeedOptions = [ScrubSpeed(name: "Slow", speed: 6),
                                        ScrubSpeed(name: "Normal", speed: 3),
                                        ScrubSpeed(name: "Fast", speed: 1)]
    }
}
