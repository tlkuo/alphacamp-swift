//
//  ACLoginViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ACLoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var loginHandler: ACLoginHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 5
        loginHandler = ACLoginHandler(delegate: self)
    }

    @IBAction func submitForm(sender: AnyObject) {

        if let email = emailField.text, password = passwordField.text {
            loginHandler?.login(email, password: password)
        }
    }

}

extension ACLoginViewController: ACLoginDelegate {

    func loginSuccess(token: String) {
        
        dispatch_async(dispatch_get_main_queue(), {
            NSUserDefaults.standardUserDefaults().setValue(token, forKey: "auth_token")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("ACTabBarController")
            
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }

    func loginFail(message: String) {
        print("login fail: \(message)")
    }
}

