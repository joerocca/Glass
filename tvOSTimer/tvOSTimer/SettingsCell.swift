//
//  SettingsCell.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/28/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
   static let reuseIdentifier = "Cell"
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuration
    
    func configureContentView(imageName: String)
    {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.contentMode = .ScaleAspectFit
        self.contentView.addSubview(imageView)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
    }
}
