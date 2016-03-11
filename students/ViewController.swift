//
//  ViewController.swift
//  students
//
//  Created by martin on 2016/3/11.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DetailDelegate {
    @IBOutlet weak var studentBtn0: UIButton!
    @IBOutlet weak var studentBtn1: UIButton!

    var class1 = Class()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        studentBtn0.setTitle(class1.students[0].name, forState: .Normal)
        studentBtn1.setTitle(class1.students[1].name, forState: .Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let desViewcontroller = segue.destinationViewController as! DetailViewController
            desViewcontroller.student = class1.students[0]
            desViewcontroller.delegate = self
        }
    }
    
    func nameChanged(new_name: String) {
        class1.students[0].name = new_name
        studentBtn0.setTitle(new_name, forState: .Normal)
    }

}

