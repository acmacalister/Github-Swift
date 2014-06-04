//
//  LoginViewController.swift
//  Github
//
//  Created by Austin Cherry on 6/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    @IBOutlet var usernameField : UITextField
    @IBOutlet var passwordField : UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func selectSignIn(sender : AnyObject) {
        println(usernameField.text)
        println(passwordField.text)
        println("we is going to login!!")
        
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
