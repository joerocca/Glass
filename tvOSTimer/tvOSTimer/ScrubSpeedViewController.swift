//
//  ScrubSpeedViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ScrubSpeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Sound Options Variable
    let scrubSpeedOptions = SettingsConstants.ScrubSpeedConstants.ScrubSpeedOptions
    
    //MARK: UI Element Variables
    var instructionsLabel: UILabel = {
        
        let instructionsLabel = UILabel()
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.text = "Press Select a Scrubbing Speed."
        instructionsLabel.textAlignment = .Center
        instructionsLabel.font = UIFont.systemFontOfSize(35.0)
        instructionsLabel.textColor = UIColor.grayColor()
        return instructionsLabel
    }()
    
    var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerClass(ScrubSpeedCell.self, forCellReuseIdentifier: ScrubSpeedCell.reuseIdentifier)
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
    
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scrubSpeedOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(ScrubSpeedCell.reuseIdentifier, forIndexPath: indexPath) as! ScrubSpeedCell
        let scrubSpeed = self.scrubSpeedOptions[indexPath.row]
        cell.composeCell(scrubSpeed)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    //    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)
    //    {
    //        let nextIndexPath = context.nextFocusedIndexPath
    //        self.fontLabel.font = UIFont(name: fontOptions[nextIndexPath!.row], size: 200.0)
    //
    //    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedScrubSpeed = self.scrubSpeedOptions[indexPath.row]
        TimerSettings.setScrubSpeed(selectedScrubSpeed)
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    //MARK: Configuration
    
    private func configureNavigationController()
    {
        self.navigationItem.title = "Scrubbing Speed"
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


}
