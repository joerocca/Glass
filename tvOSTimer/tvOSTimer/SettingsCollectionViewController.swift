//
//  SettingsCollectionViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/28/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class SettingsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let imageNames = ["Brush", "Font", "Sound", "Scrubbing"]
    
    //MARK: Initialization
    
    override init(collectionViewLayout layout: UICollectionViewLayout)
    {
        
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configureCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    //MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SettingsCell.reuseIdentifier, forIndexPath: indexPath) as! SettingsCell
        
        cell.configureContentView(imageNames[indexPath.row])
        
    
        return cell
    }
    
    //MARK: UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(45, 60, 40, 60)
    }
    
    //MARK: Configuration
    
    private func configureCollectionView()
    {
        self.collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.collectionView!.registerClass(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.reuseIdentifier)
    }

}
