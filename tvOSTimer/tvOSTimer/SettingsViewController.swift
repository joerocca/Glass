//
//  SettingsViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/26/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[tableView]-10-|", options: [], metrics: nil, views: ["tableView": tableView]))
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[tableView(400)]", options: [], metrics: nil, views: ["tableView": tableView]))
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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "SettingCell")
        cell.textLabel?.text = "Test"
        cell.textLabel?.textAlignment = .Center
        return cell
        
    }
    
    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
//    {
//        let newPoint = touches.first!.locationInView(self.view)
//        let prevPoint = touches.first!.previousLocationInView(self.view)
//        
//        
//        if (newPoint.x > prevPoint.x)
//        {
//            //finger touch went right
//      
//            
//        }
//        else
//        {
//            //finger touch went left
//         
//            
//        }
//        
//        if (newPoint.y > prevPoint.y)
//        {
//            //finger touch went downwards
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        else
//        {
//            //finger touch went upwards
//          
//        }
//        
// 
//    }

}
