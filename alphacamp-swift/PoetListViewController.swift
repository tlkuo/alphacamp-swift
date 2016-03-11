//
//  ViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class PoetListViewController: UIViewController {
    @IBOutlet weak var poetBtn0: UIButton!
    @IBOutlet weak var poetBtn1: UIButton!
    @IBOutlet weak var poetBtn2: UIButton!
    @IBOutlet weak var poetBtn3: UIButton!

    var poets = Poets()

    override func viewDidLoad() {
        super.viewDidLoad()

        poetBtn0.setTitle(poets.list[0].name, forState: .Normal)
        poetBtn1.setTitle(poets.list[1].name, forState: .Normal)
        poetBtn2.setTitle(poets.list[2].name, forState: .Normal)
        poetBtn3.setTitle(poets.list[3].name, forState: .Normal)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemList" {

            if let controller = segue.destinationViewController as? PoemListViewController,
                   button = sender as? UIButton {

                switch button {
                case poetBtn0:
                    controller.poet = poets.list[0]
                case poetBtn1:
                    controller.poet = poets.list[1]
                case poetBtn2:
                    controller.poet = poets.list[2]
                case poetBtn3:
                    controller.poet = poets.list[3]
                default:
                    controller.poet = nil
                }
            }
        }
    }

    @IBAction func showPoemList(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemList", sender: sender)
    }
}

