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
    let animator = LoginAnimator()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.delegate = self
    }
    
    @IBAction func selectSignIn(sender : AnyObject) {
        login()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        login()
        return true
    }
    
    func login() {
        let login = Login(username: usernameField.text!, password: passwordField.text!)
        login.auth({ (status: Bool) in
            if status {
                self.performSegueWithIdentifier("shuffleSlide", sender: self)
            } else {
                let alert = UIAlertView(title: "Failed to Login.", message: "Invalid Username or Password", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }

        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        //let repoVC = segue.destinationViewController
        //repoVC.transitioningDelegate = animator
        //repoVC.modalPresentationStyle = .Custom
    }
}
