//
//  ScrubSpeedCell.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ScrubSpeedCell: UITableViewCell {
    
    static let reuseIdentifier = "ScrubSpeedCell"
    
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
    
    func composeCell(scrubSpeed: ScrubSpeed)
    {
        self.textLabel!.text = scrubSpeed.name
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (scrubSpeed.name == timerSettings.scrubSpeed.name)
        {
            self.accessoryType = .Checkmark
        }
    }
}
