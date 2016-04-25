//
//  SettingsViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/26/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ThemeSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Theme Options Variable
    let themeOptions = SettingsConstants.ThemeConstants.themeOptions

    //MARK: UI Element Variables
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "tealGreyThemeImage")
        return imageView
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerClass(ThemeCell.self, forCellReuseIdentifier: ThemeCell.reuseIdentifier)
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
        return themeOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(ThemeCell.reuseIdentifier, forIndexPath: indexPath) as! ThemeCell
        let theme = themeOptions[indexPath.row]
        cell.composeCell(theme)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)
    {
        let nextIndexPath = context.nextFocusedIndexPath
        self.imageView.image = UIImage(named: themeOptions[nextIndexPath!.row].imageName)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedTheme = themeOptions[indexPath.row]
        TimerSettings.setTheme(selectedTheme)
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    
    //MARK: Configuration
    
    private func configureNavigationController()
    {
        self.navigationItem.title = "Theme"
    }

    private func configureView()
    {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    private func configureSubviews()
    {
        self.view.addSubview(self.imageView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    private func configureConstraints()
    {
        let viewDict = ["tableView": self.tableView, "imageView": self.imageView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[tableView]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[imageView(800)]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict))
    }
}
