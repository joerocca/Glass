//
//  SoundSelectViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/28/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit
import AudioToolbox

class SoundSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    var currentlyFocusedIndexPath: NSIndexPath?
    
    //MARK: Sound Options Variable
    let soundOptions = SettingsConstants.SoundConstants.SoundOptions
    
    //MARK: UI Element Variables
    var instructionsLabel: UILabel = {
        
        let instructionsLabel = UILabel()
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.text = "Press Play Button on Sound to Hear it."
        instructionsLabel.textAlignment = .Center
        instructionsLabel.font = UIFont.systemFontOfSize(35.0)
        instructionsLabel.textColor = UIColor.grayColor()
        return instructionsLabel
    }()
    
    var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerClass(SoundCell.self, forCellReuseIdentifier: SoundCell.reuseIdentifier)
        return tableView
    }()
    
    
    //MARK: Initialization
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureNavigationController()
        self.configureView()
        self.configureSubviews()
        self.configureConstraints()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Button Press Handlers
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?)
    {
        for item in presses
        {
            if item.type == .PlayPause
            {
                self.playBuzzerSound(self.soundOptions[self.currentlyFocusedIndexPath!.row])
            }
    
        }
    }
    
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.soundOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(SoundCell.reuseIdentifier, forIndexPath: indexPath) as! SoundCell
        let sound = self.soundOptions[indexPath.row]
        cell.composeCell(sound)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)
    {
        let nextIndexPath = context.nextFocusedIndexPath
        self.currentlyFocusedIndexPath = nextIndexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedSound = self.soundOptions[indexPath.row]
        TimerSettings.setSound(selectedSound)
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    //MARK: Configuration
    
    private func configureNavigationController()
    {
        self.navigationItem.title = "Sound"
    }
    
    private func configureView()
    {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    private func configureSubviews()
    {
        self.view.addSubview(self.instructionsLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    private func configureConstraints()
    {
        let viewDict = ["tableView": self.tableView, "instructionsLabel": self.instructionsLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-140-[instructionsLabel]-100-[tableView]-100-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-400-[tableView]-400-|", options: [], metrics: nil, views: viewDict))
    
        self.view.addConstraint(NSLayoutConstraint(item: self.instructionsLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
    }
    
    
    //MARK: Extras
    
    func playBuzzerSound(sound: Sound)
    {
        var soundID: SystemSoundID = 0
        let mainBundle: CFBundleRef = CFBundleGetMainBundle()
        if let ref: CFURLRef = CFBundleCopyResourceURL(mainBundle, sound.name, sound.fileType, nil)
        {
            print("Here is your ref: \(ref)")
            AudioServicesCreateSystemSoundID(ref, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
        else
        {
            print("Could not find sound file")
        }
    }
}
