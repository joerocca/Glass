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

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    //MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SettingsCell.reuseIdentifier, forIndexPath: indexPath) as! SettingsCell
        
        cell.configureContentView(imageNames[indexPath.row])
        
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        switch indexPath.row
        {
            case 0:
                print("Pressed cell \(indexPath.row)")
                self.themeCellPressed()
            case 1:
                print("Pressed cell \(indexPath.row)")
                self.fontCellPressed()
            case 2:
                print("Pressed cell \(indexPath.row)")
                self.soundCellPressed()
            case 3:
                print("Pressed cell \(indexPath.row)")
                self.scrubberCellPressed()
            default:
                print("Pressed cell \(indexPath.row)")
        }
        
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
    
    //MARK: Actions
    
    private func themeCellPressed()
    {
        let themeVC = UINavigationController(rootViewController:  ThemeSelectViewController())
        self.presentViewController(themeVC, animated: true, completion: nil)
    }
    
    private func fontCellPressed()
    {
        let fontVC = UINavigationController(rootViewController:  FontSelectViewController())
        self.presentViewController(fontVC, animated: true, completion: nil)
    }
    
    private func soundCellPressed()
    {
        let soundVC = UINavigationController(rootViewController:  SoundSelectViewController())
        self.presentViewController(soundVC, animated: true, completion: nil)
    }
    
    private func scrubberCellPressed()
    {
        
    }

}
