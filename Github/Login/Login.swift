//
//  Login.swift
//  Github
//
//  Created by Austin Cherry on 6/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import SwiftHTTP

struct Login {
    let clientId = "your id"
    let clientSecret = "your secret"
    
    init(username: String, password: String) {
        let optData = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding)
        if let data = optData {
            let basicAuth = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            auth(basicAuth)
        }
    }
    
    func auth(encoded: String) {
        println(encoded)
        var request = HTTPTask()
        request.requestSerializer = JSONRequestSerializer()
        request.responseSerializer = JSONResponseSerializer()
        request.requestSerializer.headers = ["Authorization": "Basic \(encoded)"]
        let params = ["scopes":"repo", "note": "dev", "client_id": clientId, "client_secret": clientSecret]
        request.POST("https://api.github.com/authorizations", parameters: params, success: {(response: HTTPResponse) -> Void in
            if (response.responseObject != nil) {
                let token = response.responseObject!["token"] // not safe.
                println("token: \(token)")
            }
            },failure: {(error: NSError) -> Void in
                println(error)
        })
    }
}