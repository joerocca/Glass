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
    fileprivate let scrubSpeedOptions = SettingsConstants.ScrubSpeedConstants.scrubSpeedOptions
    
    //MARK: UI Element Properties
    fileprivate let tableView: UITableView = {
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        //Constraints
        let viewDict = ["tableView": self.tableView] as [String : Any]
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-140-[tableView]-100-|", options: [], metrics: nil, views: viewDict)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-500-[tableView]-500-|", options: [], metrics: nil, views: viewDict)
        
        NSLayoutConstraint.activate(allConstraints)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedScrubSpeed = self.scrubSpeedOptions[indexPath.row]
        TimerSettings.setScrubSpeed(scrubSpeed: selectedScrubSpeed)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
