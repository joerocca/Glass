//
//  Theme.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 2/7/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation
import UIKit

class Theme: NSObject, NSCoding {
    
    //MARK: Properties
    let name: String
    let imageName: String
    let backgroundColor: UIColor
    let foregroundColor: CGColor
    
    //MARK: Initialization
    init(name: String, imageName: String, backgroundColor: UIColor, foregroundColor: CGColor) {
        self.name = name
        self.imageName = imageName
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    //MARK: NSCoding
    fileprivate let NAME_KEY = "name"
    fileprivate let IMAGE_NAME_KEY = "imageName"
    fileprivate let BACKGROUND_COLOR_KEY = "backgroundColor"
    fileprivate let FOREGROUND_COLOR_KEY = "foregroundColor"
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: NAME_KEY) as! String
        self.imageName = decoder.decodeObject(forKey: IMAGE_NAME_KEY) as! String
        self.backgroundColor = decoder.decodeObject(forKey: BACKGROUND_COLOR_KEY) as! UIColor
        let colorArray = decoder.decodeObject(forKey: FOREGROUND_COLOR_KEY) as! [CGFloat]
        self.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: colorArray)!

        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: NAME_KEY)
        coder.encode(self.imageName, forKey: IMAGE_NAME_KEY)
        coder.encode(self.backgroundColor, forKey: BACKGROUND_COLOR_KEY)
        let colors = self.foregroundColor.components
        let colorBuffer = UnsafeBufferPointer(start: colors, count: 4)
        let colorArray = [CGFloat](colorBuffer)
        coder.encode(colorArray, forKey: FOREGROUND_COLOR_KEY)
    }
}
