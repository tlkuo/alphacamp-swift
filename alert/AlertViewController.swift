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
    
    override func viewDidAppear(animated: Bool) {
        askWithAlert()
    }
    
    func askWithAlert() {
        let alert = UIAlertController(title: "問題", message: "想不想談戀愛", preferredStyle: .Alert)
        let actYes = UIAlertAction(title: "Yes", style: .Default, handler: askWithActionSheet)
        let actNo = UIAlertAction(title: "No", style: .Cancel, handler: nil)

        alert.addAction(actYes)
        alert.addAction(actNo)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    func askWithActionSheet(action: UIAlertAction) {
        let actSheet = UIAlertController(title: "問題", message: "願意跟誰談戀愛", preferredStyle: .ActionSheet)
        let actOne = UIAlertAction(title: "左手", style: .Default, handler: nil)
        let actTwo = UIAlertAction(title: "右手", style: .Cancel, handler: nil)
        
        actSheet.addAction(actOne)
        actSheet.addAction(actTwo)

        presentViewController(actSheet, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(sender: AnyObject) {
        let alert = UIAlertController(title: "Warning", message: "Don't touch me!", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Close", style: .Cancel, handler: nil)

        alert.addAction(action)

        presentViewController(alert, animated: true, completion: nil)
    }

}

