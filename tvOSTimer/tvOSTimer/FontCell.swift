//
//  FontCell.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/25/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class FontCell: UITableViewCell {

    static let reuseIdentifier = "FontCell"
    
    //MARK: Management
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.accessoryType = .None
    }
    
    //MARK: Composition
    
    func composeCell(font: String)
    {
        self.textLabel!.text = font
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (UIFont(name: font, size: 200.0) == timerSettings.font)
        {
            self.accessoryType = .Checkmark
        }
    }

}
