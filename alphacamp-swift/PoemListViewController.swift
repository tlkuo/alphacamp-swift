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

    var poemBtnArray: [UIButton] = []
    var poet: Poets.Poet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        poemBtnArray = [poemBtn0, poemBtn1]

        navTitle.title = poet?.name
        
        for i in 0..<poemBtnArray.count {
            poemBtnArray[i].setTitle(poet?.poemList[i].title, forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemDetail" {

            if let destViewController = segue.destinationViewController as? PoemDetailViewController,
                   button = sender as? UIButton,
                   index = poemBtnArray.indexOf(button) {

                destViewController.poem = poet?.poemList[index]
            }
        }
    }

    @IBAction func showPoemDetail(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemDetail", sender: sender)
    }

}
