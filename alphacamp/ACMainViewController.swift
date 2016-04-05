//
//  ACMainViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ACMainViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!

    var userHandler: ACUserHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 5
        userHandler = ACUserHandler(delegate: self)
    }
    
    override func viewDidAppear(animated: Bool) {

        if let token = NSUserDefaults.standardUserDefaults().stringForKey("auth_token") {
            print("token: \(token)")
            userHandler?.validateUser(token)
        }
    }

    func showMainPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("ACTabBarController")
            
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func clearUserInfo() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("auth_token")
    }
}

extension ACMainViewController: ACUserDelegate {

    func validateUserSuccess() {
        dispatch_async(dispatch_get_main_queue(), {
            self.showMainPage()
        })
    }

    func validateUserFail() {
        dispatch_async(dispatch_get_main_queue(), {
            print("ACUserStatus: invalid")
            self.clearUserInfo()
        })
    }
}
