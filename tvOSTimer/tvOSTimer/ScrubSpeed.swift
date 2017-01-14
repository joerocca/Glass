//
//  ScrubSpeed.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 4/24/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation

class ScrubSpeed: NSObject, NSCoding {
    
    //MARK: Properties
    let name: String
    let speed: Int
    
    //MARK: Initialization
    init(name: String, speed: Int) {
        self.name = name
        self.speed = speed
    }
    
    //MARK: NSCoding
    fileprivate let NAME_KEY = "name"
    fileprivate let SPEED_KEY = "speed"
    
    required init(coder decoder: NSCoder){
        self.name = decoder.decodeObject(forKey: NAME_KEY) as! String
        self.speed = decoder.decodeInteger(forKey: SPEED_KEY)
        
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: NAME_KEY)
        coder.encode(self.speed, forKey: SPEED_KEY)
    }
}
