//
//  SettingsViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/26/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ThemeSelectViewController: UIViewController {

    //MARK: UI Element Properties
    fileprivate let foregroundPreviewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = SettingsConstants.ThemeConstants.themeOptions.first!.backgroundColor
        return view
    }()
    
    private let fontLabel: UILabel = {
        let fontLabel = UILabel()
        fontLabel.translatesAutoresizingMaskIntoConstraints = false
        fontLabel.text = "00:30"
        fontLabel.textAlignment = .center
        fontLabel.textColor = UIColor.white
        let themeSettings = TimerSettings.fetchTimerSettingsObject()
        fontLabel.font = themeSettings.font
        return fontLabel
    }()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ThemeCell.self, forCellReuseIdentifier: ThemeCell.reuseIdentifier)
        return tableView
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Controller
        self.navigationItem.title = "Theme"
        //View
        self.view.backgroundColor = UIColor(cgColor: SettingsConstants.ThemeConstants.themeOptions.first!.foregroundColor)
        //Subviews
        self.view.addSubview(self.foregroundPreviewView)
        self.view.addSubview(self.fontLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        //Constraints
        let viewDict = ["tableView": self.tableView, "foregroundPreviewView": self.foregroundPreviewView, "fontLabel": self.fontLabel] as [String : Any]
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[tableView]-12-[foregroundPreviewView(300)]|", options: [], metrics: nil, views: viewDict)
        allConstraints.append(NSLayoutConstraint(item: self.fontLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[foregroundPreviewView]|", options: [], metrics: nil, views: viewDict)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[fontLabel]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict)
        
        NSLayoutConstraint.activate(allConstraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ThemeSelectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsConstants.ThemeConstants.themeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ThemeCell.reuseIdentifier, for: indexPath) as! ThemeCell
        let theme = SettingsConstants.ThemeConstants.themeOptions[indexPath.row]
        cell.composeCell(theme: theme)
        return cell
    }
}

extension ThemeSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextIndexPath = context.nextFocusedIndexPath {
            let themeOptions = SettingsConstants.ThemeConstants.themeOptions[nextIndexPath.row]
            self.view.backgroundColor = UIColor(cgColor: themeOptions.foregroundColor)
            self.foregroundPreviewView.backgroundColor = themeOptions.backgroundColor
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTheme = SettingsConstants.ThemeConstants.themeOptions[indexPath.row]
        TimerSettings.setTheme(theme: selectedTheme)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
