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
    
    init(username: String, password: String) {
        let optData = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding)
        if let data = optData {
            let basicAuth = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            auth(basicAuth)
        }
    }
    
    func auth(encoded: String) {
        var request = HTTPTask()
        request.requestSerializer = JSONRequestSerializer()
        request.responseSerializer = JSONResponseSerializer()
        request.requestSerializer.headers = ["Authorization": "Basic \(encoded)"]
        let params = ["scopes":"repo", "note": "dev", "client_id": clientId, "client_secret": clientSecret]
        request.POST("https://api.github.com/authorizations", parameters: params, success: {(response: HTTPResponse) -> Void in
            if let obj: AnyObject = response.responseObject {
                let auth = Authorization(JSONDecoder(obj))
                if let token = auth.token {
                    println("token: \(token)")
                    let defaults = NSUserDefaults()
                    defaults.setObject(token, forKey: "token")
                    defaults.synchronize()
                } else {
                    println("Failed to get token.")
                }
            }
            },failure: {(error: NSError) -> Void in
                println(error)
        })
    }
}