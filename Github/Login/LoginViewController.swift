//
//  LoginViewController.swift
//  Github
//
//  Created by Austin Cherry on 6/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var usernameField : UITextField
    @IBOutlet var passwordField : UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.delegate = self
    }
    
    @IBAction func selectSignIn(sender : AnyObject) {
        self.login()
    }
    
    func login() {
        println(usernameField.text)
        println(passwordField.text)
        println("we is going to login!!")
        var login = Login()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.login()
        self.performSegueWithIdentifier("shuffleSlide", sender: self)
        return true
    }
}
