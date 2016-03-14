//
//  PoemListViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class PoemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var poemTableView: UITableView!

    var poet: Poets.Poet?

    override func viewDidLoad() {
        super.viewDidLoad()

        navTitle.title = poet?.name
        poemTableView.dataSource = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showPoemTableDetail" {

            if let destViewController = segue.destinationViewController as? PoemDetailViewController,
                   indexPath = poemTableView.indexPathForSelectedRow {

                destViewController.poem = poet?.poemList[indexPath.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poet?.poemList.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PoemCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = poet?.poemList[indexPath.row].title
        
        return cell
    }

    @IBAction func showPoemDetail(sender: AnyObject) {
        self.performSegueWithIdentifier("showPoemDetail", sender: sender)
    }

}
