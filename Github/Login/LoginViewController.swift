//
//  LoginViewController.swift
//  Github
//
//  Created by Austin Cherry on 6/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var usernameField : UITextField!
    @IBOutlet var passwordField : UITextField!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.delegate = self
    }
    
    @IBAction func selectSignIn(sender : AnyObject) {
        Login(username: usernameField.text, password: passwordField.text)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        Login(username: usernameField.text, password: passwordField.text)
        self.performSegueWithIdentifier("shuffleSlide", sender: self)
        return true
    }
}
