//
//  ViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class PoetListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var poetTableView: UITableView!

    var poets = Poets()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        poetTableView.dataSource = self
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemTableList" {

            if let destViewController = segue.destinationViewController as? PoemListViewController,
                   indexPath = poetTableView.indexPathForSelectedRow {
                    
                destViewController.poet = poets.list[indexPath.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poets.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PoetCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = poets.list[indexPath.row].name
        
        return cell
    }

    @IBAction func showPoemList(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemList", sender: sender)
    }
}

