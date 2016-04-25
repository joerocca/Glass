//
//  FontSelectViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class FontSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Font Options Variable
    let fontOptions = SettingsConstants.FontConstants.fontOptions
    
    //MARK: UI Element Variables
    var fontLabel: UILabel = {
        
        let fontLabel = UILabel()
        fontLabel.translatesAutoresizingMaskIntoConstraints = false
        fontLabel.text = "00:00"
        fontLabel.textAlignment = .Center
        fontLabel.font = UIFont.systemFontOfSize(200.0)
        return fontLabel
    }()
    
    var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerClass(FontCell.self, forCellReuseIdentifier: FontCell.reuseIdentifier)
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
        return fontOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(FontCell.reuseIdentifier, forIndexPath: indexPath) as! FontCell
        let font = fontOptions[indexPath.row]
        cell.composeCell(font)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)
    {
        let nextIndexPath = context.nextFocusedIndexPath
        self.fontLabel.font = UIFont(name: fontOptions[nextIndexPath!.row], size: 200.0)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedFont = fontOptions[indexPath.row]
        TimerSettings.setFont(UIFont(name: selectedFont, size: 200.0)!)
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }

    
    
    //MARK: Configuration
    
    private func configureNavigationController()
    {
        self.navigationItem.title = "Font"
    }
    
    private func configureView()
    {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    private func configureSubviews()
    {
        self.view.addSubview(self.fontLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    private func configureConstraints()
    {
        let viewDict = ["tableView": self.tableView, "fontLabel": self.fontLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[tableView]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint(item: self.fontLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[fontLabel]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict))
    }
}
