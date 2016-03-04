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
    
    //MARK: Variables
    let name: String
    let imageName: String
    let backgroundColor: UIColor
    let foregroundColor: CGColorRef
    
    //MARK: Initialization
    
    init(name: String, imageName: String, backgroundColor: UIColor, foregroundColor: CGColorRef)
    {
        self.name = name
        self.imageName = imageName
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    //MARK: NSCoding
    
    private let NAME_KEY = "name"
    private let IMAGE_NAME_KEY = "imageName"
    private let BACKGROUND_COLOR_KEY = "backgroundColor"
    private let FOREGROUND_COLOR_KEY = "foregroundColor"
    
    required init(coder decoder: NSCoder) {
        //Error here "missing argument for parameter name in call
        
        self.name = decoder.decodeObjectForKey(NAME_KEY) as! String
        self.imageName = decoder.decodeObjectForKey(IMAGE_NAME_KEY) as! String
        self.backgroundColor = decoder.decodeObjectForKey(BACKGROUND_COLOR_KEY) as! UIColor
        let colorArray = decoder.decodeObjectForKey(FOREGROUND_COLOR_KEY) as! [CGFloat]
        self.foregroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), colorArray)!

        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.name, forKey: NAME_KEY)
        coder.encodeObject(self.imageName, forKey: IMAGE_NAME_KEY)
        coder.encodeObject(self.backgroundColor, forKey: BACKGROUND_COLOR_KEY)
        let colors = CGColorGetComponents(self.foregroundColor)
        let colorBuffer = UnsafeBufferPointer(start: colors, count: 4)
        let colorArray = [CGFloat](colorBuffer)
        coder.encodeObject(colorArray, forKey: FOREGROUND_COLOR_KEY)
        
    }
    
}