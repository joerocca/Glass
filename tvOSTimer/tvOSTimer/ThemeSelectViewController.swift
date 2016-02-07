//
//  SettingsViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/26/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ThemeSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let themeOptions = SettingsConstants.ThemeConstants.themeOptions

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Theme"
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "tealGreyThemeImage")
        self.view.addSubview(imageView)
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let viewDict = ["tableView": tableView, "imageView": imageView]

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[tableView]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[imageView(800)]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict))
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
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "SettingCell")
        let theme = themeOptions[indexPath.row]
        cell.textLabel!.text = theme.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let theme = themeOptions[indexPath.row]
        let themeData = NSKeyedArchiver.archivedDataWithRootObject(theme)
        NSUserDefaults.standardUserDefaults().setObject(themeData, forKey: SettingsConstants.ThemeConstants.themeKey)
    }

}
