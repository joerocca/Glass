//
//  ScrubSpeedViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class ScrubSpeedViewController: UIViewController {

    //MARK: Properties
    let scrubSpeedOptions = SettingsConstants.ScrubSpeedConstants.ScrubSpeedOptions
    
    //MARK: UI Element Properties
    var instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.text = "Press Select a Scrubbing Speed."
        instructionsLabel.textAlignment = .center
        instructionsLabel.font = UIFont.systemFont(ofSize: 35.0)
        instructionsLabel.textColor = UIColor.gray
        return instructionsLabel
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScrubSpeedCell.self, forCellReuseIdentifier: ScrubSpeedCell.reuseIdentifier)
        return tableView
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Controller
        self.navigationItem.title = "Scrubbing Speed"
        //View
        self.view.backgroundColor = UIColor.white
        //Subviews
        self.view.addSubview(self.instructionsLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        //Constraints
        let viewDict = ["tableView": self.tableView, "instructionsLabel": self.instructionsLabel] as [String : Any]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-140-[instructionsLabel]", options: [], metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-400-[tableView]-400-|", options: [], metrics: nil, views: viewDict))
        self.view.addConstraint(self.tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor))
        self.view.addConstraint(self.tableView.heightAnchor.constraint(equalToConstant: 300.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.instructionsLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScrubSpeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scrubSpeedOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScrubSpeedCell.reuseIdentifier, for: indexPath) as! ScrubSpeedCell
        let scrubSpeed = self.scrubSpeedOptions[indexPath.row]
        cell.composeCell(scrubSpeed: scrubSpeed)
        return cell
    }
}

extension ScrubSpeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedScrubSpeed = self.scrubSpeedOptions[indexPath.row]
        TimerSettings.setScrubSpeed(scrubSpeed: selectedScrubSpeed)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
