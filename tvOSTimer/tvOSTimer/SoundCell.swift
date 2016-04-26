//
//  SoundCell.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 3/4/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class SoundCell: UITableViewCell {

    static let reuseIdentifier = "SoundCell"
    
    //MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Management
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.accessoryType = .None
    }
    
    //MARK: Configuration
    
    private func configureCell()
    {
       self.textLabel!.textAlignment = .Center
    }
    
    //MARK: Composition
    
    func composeCell(sound: Sound)
    {
        self.textLabel!.text = sound.name
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (sound.name == timerSettings.sound.name)
        {
            self.accessoryType = .Checkmark
        }
    }
}
