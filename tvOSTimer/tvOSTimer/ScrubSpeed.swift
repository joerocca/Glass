//
//  ScrubSpeed.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation

class ScrubSpeed: NSObject, NSCoding {
    
    //MARK: Variables
    let name: String
    let speed: Int
    
    //MARK: Initialization
    
    init(name: String, speed: Int)
    {
        self.name = name
        self.speed = speed
    }
    
    //MARK: NSCoding
    
    private let NAME_KEY = "name"
    private let SPEED_KEY = "speed"
    
    required init(coder decoder: NSCoder)
    {
        //Error here "missing argument for parameter name in call
        
        self.name = decoder.decodeObjectForKey(NAME_KEY) as! String
        self.speed = decoder.decodeIntegerForKey(SPEED_KEY)
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.name, forKey: NAME_KEY)
        coder.encodeInteger(self.speed, forKey: SPEED_KEY)
    }
    
}