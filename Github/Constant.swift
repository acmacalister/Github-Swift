//
//  Constant.swift
//  Github
//
//  Created by Austin Cherry on 9/28/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import Foundation

class Constant {
    private var t: String? // internal storage of token property.
    var token: String? {
        get {
            if t == nil {
                let defaults = NSUserDefaults()
                t  = defaults.objectForKey("token") as? String
                return t
            }
            return t
        }
        set {
            let defaults = NSUserDefaults()
            defaults.setObject(newValue, forKey: "token")
            defaults.synchronize()
            t = newValue
        }
    }
    
    class var sharedManager : Constant {
        
    struct Static {
        static let instance : Constant = Constant()
        }
        return Static.instance
    }
}