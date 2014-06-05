//
//  Login.swift
//  Github
//
//  Created by Austin Cherry on 6/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import UIKit

class Login: NSObject {
    var session = NSURLSession.sharedSession()
    var str : NSString!
    
    init() {
        println("do stuff")
    }
    
    func oauthRequest() {
        var task = session.dataTaskWithURL(NSURL.URLWithString("http://vluxe.io"), completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            self.str = NSString(data: data, encoding: NSUTF8StringEncoding)
        })
        
        task.resume()
    }
}
