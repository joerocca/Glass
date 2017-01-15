//
//  SettingsViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/26/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ThemeSelectViewController: UIViewController {

    //MARK: Properties
    let themeOptions = SettingsConstants.ThemeConstants.themeOptions

    //MARK: UI Element Properties
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "tealGreyThemeImage")
        return imageView
    }()
    
    var tableView: UITableView = {
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
        self.view.backgroundColor = UIColor.white
        //Subviews
        self.view.addSubview(self.imageView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        //Constraints
        let viewDict = ["tableView": self.tableView, "imageView": self.imageView] as [String : Any]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[tableView]-200-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[imageView(800)]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict))
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
        return self.themeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ThemeCell.reuseIdentifier, for: indexPath) as! ThemeCell
        let theme = self.themeOptions[indexPath.row]
        cell.composeCell(theme: theme)
        return cell
    }
}

extension ThemeSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextIndexPath = context.nextFocusedIndexPath {
            self.imageView.image = UIImage(named: themeOptions[nextIndexPath.row].imageName)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTheme = themeOptions[indexPath.row]
        TimerSettings.setTheme(theme: selectedTheme)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
