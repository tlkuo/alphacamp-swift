//
//  Nav1ViewController.swift
//  navigation
//
//  Created by martin on 2016/3/17.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class Nav1ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!

    static var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        countLabel.text = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        countLabel.text = "第 \(++Nav1ViewController.count) 次"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

