//
//  Sound.swift
//  tvOSTimer
//
//  Created by Joe Rocca on 3/4/16.
//  Copyright © 2016 Joe Rocca. All rights reserved.
//

import Foundation

class Sound: NSObject, NSCoding {
    
    //MARK: Properties
    let name: String
    let fileType: String
    
    //MARK: Initialization
    init(name: String, fileType: String) {
        self.name = name
        self.fileType = fileType
    }
    
    //MARK: NSCoding
    fileprivate let NAME_KEY = "name"
    fileprivate let FILE_NAME_KEY = "fileName"
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: NAME_KEY) as! String
        self.fileType = decoder.decodeObject(forKey: FILE_NAME_KEY) as! String
        
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: NAME_KEY)
        coder.encode(self.fileType, forKey: FILE_NAME_KEY)
    }
    
}
