//
//  Nav2ViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/17.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class Nav2ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    static var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        countLabel.text = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        countLabel.text = "第 \(++Nav2ViewController.count) 次"
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

}
