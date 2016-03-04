//
//  Sound.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 3/4/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation

class Sound: NSObject, NSCoding {
    
    //MARK: Variables
    let name: String
    let fileType: String
    
    //MARK: Initialization
    
    init(name: String, fileType: String)
    {
        self.name = name
        self.fileType = fileType
    }
    
    //MARK: NSCoding
    
    private let NAME_KEY = "name"
    private let FILE_NAME_KEY = "fileName"
    
    required init(coder decoder: NSCoder)
    {
        //Error here "missing argument for parameter name in call
        
        self.name = decoder.decodeObjectForKey(NAME_KEY) as! String
        self.fileType = decoder.decodeObjectForKey(FILE_NAME_KEY) as! String
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.name, forKey: NAME_KEY)
        coder.encodeObject(self.fileType, forKey: FILE_NAME_KEY)
    }
    
}
