//
//  ViewController.swift
//  alert
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    @IBOutlet weak var poemLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let poem = NSBundle.mainBundle().pathForResource("poem", ofType: ".txt") {

            if let poemString = try? String(contentsOfFile: poem) {
                poemLabel.text = poemString
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: AnyObject) {
        let ctrler = UIAlertController(title: "Warning", message: "Don't touch me!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Close", style: .Cancel, handler: nil)

        ctrler.addAction(action)

        presentViewController(ctrler, animated: true, completion: nil)
    }

}

