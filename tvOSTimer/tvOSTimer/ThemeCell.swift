//
//  ThemeCell.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/25/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    static let reuseIdentifier = "ThemeCell"
    
    //MARK: Management
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.accessoryType = .None
    }
    
    //MARK: Composition
    
    func composeCell(theme: Theme)
    {
        self.textLabel!.text = theme.name
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (theme.name == timerSettings.theme.name)
        {
            self.accessoryType = .Checkmark
        }
    }

}
