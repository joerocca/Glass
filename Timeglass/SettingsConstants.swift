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
        static let themeOptions = [Theme(name: "Cool Guy", backgroundColor: UIColor(red:0.26, green:0.29, blue:0.33, alpha:1.00), foregroundColor: UIColor(red:0.01, green:0.6, blue:0.54, alpha:1.00).cgColor),
                                   Theme(name: "Sunshine", backgroundColor: UIColor(red:0.65, green:0.25, blue:0.01, alpha:1.00), foregroundColor: UIColor(red:0.85, green:0.57, blue:0.05, alpha:1.00).cgColor),
                                   Theme(name: "Sky", backgroundColor: UIColor(red:0.19, green:0.22, blue:0.36, alpha:1.00), foregroundColor: UIColor(red:0.29, green:0.39, blue:0.57, alpha:1.00).cgColor),
                                   Theme(name: "Rose", backgroundColor: UIColor(red:0.39, green:0.31, blue:0.37, alpha:1.00), foregroundColor: UIColor(red:0.65, green:0.45, blue:0.50, alpha:1.00).cgColor),
                                   Theme(name: "Black Pearl", backgroundColor: UIColor(red:0.00, green:0.08, blue:0.15, alpha:1.00), foregroundColor: UIColor(red:0.15, green:0.25, blue:0.31, alpha:1.00).cgColor),
                                   Theme(name: "Forest", backgroundColor: UIColor(red:0.25, green:0.35, blue:0.32, alpha:1.00), foregroundColor: UIColor(red:0.61, green:0.61, blue:0.48, alpha:1.00).cgColor),
                                   Theme(name: "Pomegranate", backgroundColor: UIColor(red:0.80, green:0.17, blue:0.14, alpha:1.00), foregroundColor: UIColor(red:0.95, green:0.35, blue:0.29, alpha:1.00).cgColor),
                                   Theme(name: "Plume", backgroundColor: UIColor(red:0.17, green:0.13, blue:0.20, alpha:1.00), foregroundColor: UIColor(red:0.37, green:0.00, blue:0.26, alpha:1.00).cgColor),
                                   Theme(name: "Harbor", backgroundColor: UIColor(red:0.18, green:0.22, blue:0.22, alpha:1.00), foregroundColor: UIColor(red:0.39, green:0.46, blue:0.47, alpha:1.00).cgColor)]
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
        static let soundOptions = [Sound(name: "Buzzer 1", fileType: "mp3"),
                                   Sound(name: "Buzzer 2", fileType: "mp3"),
                                   Sound(name: "Buzzer 3", fileType: "mp3"),
                                   Sound(name: "Magic Chime", fileType: "mp3"),
                                   Sound(name: "Censor Beep", fileType: "mp3"),
                                   Sound(name: "Dream Harp", fileType: "mp3"),
                                   Sound(name: "Trumpet", fileType: "mp3"),
                                   Sound(name: "Melodica", fileType: "mp3"),
                                   Sound(name: "Whistle Flute", fileType: "mp3"),
                                   Sound(name: "Squeeze Toy 1", fileType: "mp3"),
                                   Sound(name: "Squeeze Toy 2", fileType: "mp3"),
                                   Sound(name: "Bulb Horn", fileType: "mp3"),
                                   Sound(name: "Velcro", fileType: "mp3"),
                                   Sound(name: "Pill Bottle", fileType: "mp3"),
                                   Sound(name: "Paper Rip", fileType: "mp3"),
                                   Sound(name: "Coin Drop", fileType: "mp3"),
                                   Sound(name: "Small Bell", fileType: "mp3")]
    }
    
    //MARK: Scrub Speed Constants
    struct ScrubSpeedConstants {
        static let scrubSpeedOptions = [ScrubSpeed(name: "Slow", speed: 9),
                                        ScrubSpeed(name: "Normal", speed: 6),
                                        ScrubSpeed(name: "Fast", speed: 3)]
    }
}
