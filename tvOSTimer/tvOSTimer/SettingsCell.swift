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
    
    //MARK: UI Element Variables
    var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    
    //MARK: Initialization
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.configureUIElements()
        self.configureConstraints()
    }
    
    //MARK: NSCoding Functions

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuration
    
    private func configureUIElements()
    {
        self.contentView.addSubview(self.imageView)
    }
    
    private func configureConstraints()
    {
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: [], metrics: nil, views: ["imageView": self.imageView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: [], metrics: nil, views: ["imageView": self.imageView]))
    }
    
    //MARK: Composition
    
    func configureContentView(imageName: String)
    {
        self.imageView.image = UIImage(named: imageName)
    }
    
}
