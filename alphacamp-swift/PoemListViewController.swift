//
//  PoemListViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class PoemListViewController: UIViewController {
    @IBOutlet weak var poemBtn0: UIButton!
    @IBOutlet weak var poemBtn1: UIButton!
    
    var poemList: [Poets.Poem]?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let list = poemList {
            poemBtn0.setTitle(list[0].title, forState: .Normal)
            poemBtn1.setTitle(list[1].title, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemDetail" {

            if let controller = segue.destinationViewController as? PoemDetailViewController,
                   button = sender as? UIButton {

                switch button {
                case poemBtn0:
                    controller.poem = poemList?[0]
                case poemBtn1:
                    controller.poem = poemList?[1]
                default:
                    controller.poem = nil
                }
            }
        }
    }

    @IBAction func showPoemDetail(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemDetail", sender: sender)
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
