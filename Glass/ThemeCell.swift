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
    
    //MARK: Cell Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    //MARK: Composition
    func composeCell(theme: Theme) {
        guard let textLabel = self.textLabel else {
            fatalError("textLabel is nil.")
        }
        textLabel.text = theme.name
        let timerSettings = TimerSettings.fetchTimerSettingsObject()
        if (theme.name == timerSettings.theme.name) {
            self.accessoryType = .checkmark
        }
    }

}
