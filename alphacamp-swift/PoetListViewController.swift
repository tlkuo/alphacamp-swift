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

    var poetBtnArray: [UIButton] = []
    var poets = Poets()

    override func viewDidLoad() {
        super.viewDidLoad()

        poetBtnArray = [poetBtn0, poetBtn1, poetBtn2, poetBtn3]

        for i in 0..<poetBtnArray.count {
            poetBtnArray[i].setTitle(poets.list[i].name, forState: .Normal)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemList" {

            if let destViewController = segue.destinationViewController as? PoemListViewController,
                   button = sender as? UIButton,
                   index = poetBtnArray.indexOf(button) {

                destViewController.poet = poets.list[index]
            }
        }
    }

    @IBAction func showPoemList(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemList", sender: sender)
    }
}

