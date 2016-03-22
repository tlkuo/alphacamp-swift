//
//  FileViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/22.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class FileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var itemTableView: UITableView!

    var itemPath: String = NSHomeDirectory().stringByAppendingString("/items.txt")

    var itemList: NSArray? {
        didSet {
            itemList?.writeToFile(itemPath, atomically: true)
            itemTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemList = NSArray(contentsOfFile: itemPath) ?? []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = itemList?[indexPath.row] as? String

        return cell
    }

    @IBAction func clearItem(sender: AnyObject) {
        itemList = []
    }

    @IBAction func newItem(sender: AnyObject) {
        
        if var list = itemList as? [String] {
            list.append("電影 " + String(list.count + 1))
            itemList = list
        }
    }
}
