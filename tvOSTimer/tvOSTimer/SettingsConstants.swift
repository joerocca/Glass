//
//  SettingsConstants.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation
import UIKit

struct SettingsConstants
{
    static let timerSettingsKey = "SETTINGS_KEY"
    
    //MARK: Theme Constants
    struct ThemeConstants
    {
        static let themeOptions = [Theme(name: "Cool Guy", imageName: "CoolGuyThemeImage", backgroundColor: UIColor(red:0.26, green:0.29, blue:0.33, alpha:1), foregroundColor: UIColor(red:0.01, green:0.6, blue:0.54, alpha:1.0).CGColor), Theme(name: "Sunshine", imageName: "SunshineThemeImage", backgroundColor: UIColor.yellowColor(), foregroundColor: UIColor.orangeColor().CGColor)]
    }
    
    //MARK: Font Constants
    struct FontConstants
    {
       static let fontOptions = UIFont.familyNames()
    }
    
    struct SoundConstants
    {
        static let SoundOptions = []
    }


}