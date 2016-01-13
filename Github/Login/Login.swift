//
//  Login.swift
//  Github
//
//  Created by Austin Cherry on 6/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import SwiftHTTP
import JSONJoy

struct App: JSONJoy {
    var url: String?
    var name: String?
    var clientId: String?
    
    init(_ decoder: JSONDecoder) {
        url = decoder["url"].string
        name = decoder["name"].string
        clientId = decoder["client_id"].string
    }
}

struct Authorization: JSONJoy {
    var id: Int?
    var url: String?
    //var scopes: Array<String>?
    var app: App?
    var token: String?
    var note: String?
    var noteUrl: String?
    //var updatedAt: String?
    //var createdAt: String?
    
    init(_ decoder: JSONDecoder) {
        id = decoder["id"].integer
        url = decoder["url"].string
        //decoder["scopes"].array(&scopes)
        app = App(decoder["app"])
        token = decoder["token"].string
        note = decoder["note"].string
        noteUrl = decoder["note_url"].string
        //updatedAt = decoder["updated_at"].string
        //createdAt = decoder["created_at"].string
    }
}

struct Login {
    let clientId = "80b1798b0b410dd723ee"
    let clientSecret = "58b7abd90008cb39626802d4bb9444c53d9d79ad"
    var basicAuth = ""
    
    init(username: String, password: String) {
        let optData = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding)
        if let data = optData {
            basicAuth = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        }
    }
    
    func auth(completionHandler: (Bool -> Void)) -> Void {
        
        let params = ["scopes":"repo", "note": "dev", "client_id": clientId, "client_secret": clientSecret]
        
        do {
            let opt = try HTTP.POST("https://api.github.com/authorizations", parameters: params, headers: ["Authorization": "Basic \(basicAuth)"] ,requestSerializer: JSONParameterSerializer())
            opt.start { response in
                if let error = response.error {
                    print("got an error: \(error)")
                    dispatch_async(dispatch_get_main_queue(),{
                        completionHandler(false)
                    })
                    
                    return //also notify app of failure as needed
                }
                let auth = Authorization(JSONDecoder(response.data))
                if let token = auth.token {
                    print("token: \(token)")
                    let defaults = NSUserDefaults()
                    defaults.setObject(token, forKey: "token")
                    defaults.synchronize()
                    dispatch_async(dispatch_get_main_queue(),{
                        completionHandler(true)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(),{
                        completionHandler(false)
                    })
                }
                
            }
        } catch let error {
            dispatch_async(dispatch_get_main_queue(),{
                completionHandler(false)
            })
            print("got an error creating the request: \(error)")
        }
    }
}