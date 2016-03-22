//
//  ACLoginFormViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ACLoginFormViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let loginHandler: ACLoginHandler = ACLoginHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func submitForm(sender: AnyObject) {

        if let email = emailField.text, password = passwordField.text {
            loginHandler.login(email, password: password)
        }
    }

}
