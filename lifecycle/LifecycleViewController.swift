//
//  LifecycleViewController.swift
//  lifecycle
//
//  Created by martin on 2016/3/27.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class LifecycleViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    let app = UIApplication.sharedApplication().delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        udpateLabel(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func udpateLabel(count: Int) {
        label.text = String(count)
    }

}

