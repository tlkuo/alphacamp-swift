//
//  PoemListViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class PoemListViewController: UIViewController {
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var poemBtn0: UIButton!
    @IBOutlet weak var poemBtn1: UIButton!

    var poet: Poets.Poet?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = poet {
            navTitle.title = p.name
            poemBtn0.setTitle(p.poemList[0].title, forState: .Normal)
            poemBtn1.setTitle(p.poemList[1].title, forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemDetail" {

            if let controller = segue.destinationViewController as? PoemDetailViewController,
                   button = sender as? UIButton {

                switch button {
                case poemBtn0:
                    controller.poem = poet?.poemList[0]
                case poemBtn1:
                    controller.poem = poet?.poemList[1]
                default:
                    controller.poem = nil
                }
            }
        }
    }

    @IBAction func showPoemDetail(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemDetail", sender: sender)
    }

}
