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

    var userManager: ACUserManager?
    var originControllers: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 5
        userManager = ACUserManager(delegate: self)
    }

    func showPreviousController() {

        if let controllers = originControllers {
            navigationController?.setViewControllers(controllers, animated: true)
        }
    }

    func clearUserInfo() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("auth_token")
    }
}

extension ACMainViewController: ACUserDelegate {

    func validateUserSuccess() {
        dispatch_async(dispatch_get_main_queue(), {
            self.showPreviousController()
        })
    }

    func validateUserFail() {
        dispatch_async(dispatch_get_main_queue(), {
            print("ACUserStatus: invalid")
            self.clearUserInfo()
        })
    }
}
