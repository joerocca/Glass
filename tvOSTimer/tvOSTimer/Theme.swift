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
    
    let name: String
    let backgroundColor: UIColor
    let foregroundColor: CGColorRef
    
    init(name: String, backgroundColor: UIColor, foregroundColor: CGColorRef)
    {
        self.name = name
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    required init(coder decoder: NSCoder) {
        //Error here "missing argument for parameter name in call
        
        self.name = decoder.decodeObjectForKey("name") as! String
        self.backgroundColor = decoder.decodeObjectForKey("backgroundColor") as! UIColor
        let colorArray = decoder.decodeObjectForKey("foregroundColor") as! [CGFloat]
        self.foregroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), colorArray)!

        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.backgroundColor, forKey: "backgroundColor")
        let colors = CGColorGetComponents(self.foregroundColor)
        let colorBuffer = UnsafeBufferPointer(start: colors, count: 4)
        let colorArray = [CGFloat](colorBuffer)
        coder.encodeObject(colorArray, forKey: "foregroundColor")
        
    }
    
}