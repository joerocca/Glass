//
//  SettingsCell.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 1/28/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SettingsCell"
    
    //MARK: UI Element Properties
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Subviews
        self.contentView.addSubview(self.imageView)
        //Constraints
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: ["imageView": self.imageView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: ["imageView": self.imageView]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Composition
    func composeCell(imageName: String) {
        self.imageView.image = UIImage(named: imageName)
    }
}
