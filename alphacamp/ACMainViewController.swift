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

    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 5
    }
}
