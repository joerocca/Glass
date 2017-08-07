//
//  SettingsCollectionViewController.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/28/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class SettingsCollectionViewController: UICollectionViewController {
    
    //MARK: Properties
    private let imageNames = ["Brush", "Font", "Sound", "Scrubbing"]
    
    //MARK: Initialization
    init() {
        let interitemSpacing = CGFloat(120)
        let lineSpacing = CGFloat(90)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - interitemSpacing, height: UIScreen.main.bounds.height/2 - lineSpacing)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = interitemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //View
        self.view.backgroundColor = UIColor.white
        //Collection View
        guard let collectionView = self.collectionView else {
            fatalError("UICollectionView is nil.")
        }
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    //MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as! SettingsCell
        cell.composeCell(imageName: imageNames[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                self.themeCellPressed()
            case 1:
                self.fontCellPressed()
            case 2:
                self.soundCellPressed()
            case 3:
                self.scrubberCellPressed()
            default: break
        }
        
    }
    
    //MARK: Actions
    fileprivate func themeCellPressed() {
        let themeVC = UINavigationController(rootViewController:  ThemeSelectViewController())
        self.present(themeVC, animated: true, completion: nil)
    }
    
    fileprivate func fontCellPressed() {
        let fontVC = UINavigationController(rootViewController:  FontSelectViewController())
        self.present(fontVC, animated: true, completion: nil)
    }
    
    fileprivate func soundCellPressed() {
        let soundVC = UINavigationController(rootViewController:  SoundSelectViewController())
        self.present(soundVC, animated: true, completion: nil)
    }
    
    fileprivate func scrubberCellPressed() {
        let scrubSpeedVC = UINavigationController(rootViewController:  ScrubSpeedViewController())
        self.present(scrubSpeedVC, animated: true, completion: nil)
    }
}

extension SettingsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(45, 60, 40, 60)
    }
}
