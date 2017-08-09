//
//  SoundSelectViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/28/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit
import AudioToolbox

class SoundSelectViewController: UIViewController {
    
    //MARK: Properties
    fileprivate var currentlyFocusedIndexPath: IndexPath?
    fileprivate let soundOptions = SettingsConstants.SoundConstants.soundOptions
    
    //MARK: UI Element Properties
    private let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.text = "Press Play Button On A Sound To Hear It."
        instructionsLabel.textAlignment = .center
        instructionsLabel.font = UIFont.systemFont(ofSize: 35.0)
        instructionsLabel.textColor = UIColor.gray
        return instructionsLabel
    }()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SoundCell.self, forCellReuseIdentifier: SoundCell.reuseIdentifier)
        return tableView
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Controller
        self.navigationItem.title = "Sound"
        //View
        self.view.backgroundColor = UIColor.white
        //Subviews
        self.view.addSubview(self.instructionsLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        //Constraints
        let viewDict = ["tableView": self.tableView, "instructionsLabel": self.instructionsLabel] as [String : Any]
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-140-[instructionsLabel]-100-[tableView]-100-|", options: [], metrics: nil, views: viewDict)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-500-[tableView]-500-|", options: [], metrics: nil, views: viewDict)
        allConstraints.append(NSLayoutConstraint(item: self.instructionsLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Press Handlers
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            if item.type == .playPause {
                guard let currentlyFocusedIndexPath = self.currentlyFocusedIndexPath else {
                    return
                }
                let sound = self.soundOptions[currentlyFocusedIndexPath.row]
                self.playBuzzer(sound: sound)
            }
        }
    }

    //MARK: Helpers
    func playBuzzer(sound: Sound) {
        var soundID: SystemSoundID = 0
        let mainBundle: CFBundle = CFBundleGetMainBundle()
        if let ref: CFURL = CFBundleCopyResourceURL(mainBundle, sound.name as CFString!, sound.fileType as CFString!, nil) {
            print("Here is your ref: \(ref)")
            AudioServicesCreateSystemSoundID(ref, &soundID)
            AudioServicesPlaySystemSound(soundID)
        } else {
            print("Could not find sound file")
        }
    }
}

extension SoundSelectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.soundOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SoundCell.reuseIdentifier, for: indexPath) as! SoundCell
        let sound = self.soundOptions[indexPath.row]
        cell.composeCell(sound: sound)
        return cell
    }
}

extension SoundSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let nextIndexPath = context.nextFocusedIndexPath
        self.currentlyFocusedIndexPath = nextIndexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSound = self.soundOptions[indexPath.row]
        TimerSettings.setSound(sound: selectedSound)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
