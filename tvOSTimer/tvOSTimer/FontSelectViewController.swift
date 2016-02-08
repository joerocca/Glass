//
//  FontSelectViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class FontSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let fontOptions = SettingsConstants.FontConstants.fontOptions
    
    var fontLabel: UILabel = {
        
        let fontLabel = UILabel()
        fontLabel.translatesAutoresizingMaskIntoConstraints = false
        fontLabel.text = "00:00"
        fontLabel.textAlignment = .Center
        fontLabel.font = UIFont.systemFontOfSize(200.0)
        return fontLabel
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Font"
        
        self.view.addSubview(fontLabel)
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let viewDict = ["tableView": tableView, "fontLabel": fontLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[tableView]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint(item: fontLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[fontLabel(800)]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict))
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
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "SettingCell")
        let font = fontOptions[indexPath.row]
        cell.textLabel!.text = font
        
        return cell
    }
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)
    {
        let nextIndexPath = context.nextFocusedIndexPath
        self.fontLabel.font = UIFont(name: fontOptions[nextIndexPath!.row], size: 200.0)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedFont = fontOptions[indexPath.row]
        
        TimerSettings.setFont(UIFont(name: selectedFont, size: 200.0)!)
    }

}
