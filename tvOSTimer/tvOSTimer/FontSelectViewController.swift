//
//  FontSelectViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class FontSelectViewController: UIViewController {

    //MARK: Properties
    fileprivate let fontOptions = SettingsConstants.FontConstants.fontOptions
    
    //MARK: UI Element Properties
    fileprivate let fontLabel: UILabel = {
        let fontLabel = UILabel()
        fontLabel.translatesAutoresizingMaskIntoConstraints = false
        fontLabel.text = "00:00"
        fontLabel.textAlignment = .center
        fontLabel.font = UIFont.systemFont(ofSize: 200.0)
        return fontLabel
    }()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FontCell.self, forCellReuseIdentifier: FontCell.reuseIdentifier)
        return tableView
    }()
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Controller
        self.navigationItem.title = "Font"
        //View
        self.view.backgroundColor = UIColor.white
        //Subviews
        self.view.addSubview(self.fontLabel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        //Constraints
        let viewDict = ["tableView": self.tableView, "fontLabel": self.fontLabel] as [String : Any]
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[tableView]-|", options: [], metrics: nil, views: viewDict)
        allConstraints.append(NSLayoutConstraint(item: self.fontLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[fontLabel]-150-[tableView]-80-|", options: [], metrics: nil, views: viewDict)
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FontSelectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fontOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FontCell.reuseIdentifier, for: indexPath) as! FontCell
        let font = self.fontOptions[indexPath.row]
        cell.composeCell(font: font)
        return cell
    }
}

extension FontSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextIndexPath = context.nextFocusedIndexPath {
            self.fontLabel.font = UIFont(name: fontOptions[nextIndexPath.row], size: 200.0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFont = fontOptions[indexPath.row]
        TimerSettings.setFont(font: UIFont(name: selectedFont, size: 200.0)!)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
