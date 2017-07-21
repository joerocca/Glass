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
    
    //MARK: Cell Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    //MARK: Composition
    func composeCell(sound: Sound) {
        guard let textLabel = self.textLabel else {
            fatalError("textLabel is nil.")
        }
        textLabel.text = sound.name
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (sound.name == timerSettings.sound.name) {
            self.accessoryType = .checkmark
        }
    }
}
