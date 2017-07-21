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
    
    //MARK: Cell Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    //MARK: Composition
    func composeCell(scrubSpeed: ScrubSpeed) {
        guard let textLabel = self.textLabel else {
            fatalError("textLabel is nil.")
        }
        textLabel.text = scrubSpeed.name
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (scrubSpeed.name == timerSettings.scrubSpeed.name) {
            self.accessoryType = .checkmark
        }
    }
}
