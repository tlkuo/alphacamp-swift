//
//  ViewController.swift
//  data
//
//  Created by martin on 2016/3/23.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit
import CoreData

class DataViewController: UIViewController {

    @IBOutlet weak var bookTable: UITableView!
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var bookArray: [Book] = [] {
        didSet {
            bookTable.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let request = NSFetchRequest(entityName: "Book")
        let descriptor = NSSortDescriptor(key: "author", ascending: true)
        //let predicate = NSPredicate(format: "author == %@", "Author1")
        
        request.sortDescriptors = [descriptor]
        //request.predicate = predicate
        
        if let result = try? managedObjectContext.executeFetchRequest(request), books = result as? [Book] {
            bookArray = books
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "ShowDataForm" {
            
            guard let desController = segue.destinationViewController as? DataFormViewController else {
                return
            }
            
            if let cell = sender as? UITableViewCell, indexPath = bookTable.indexPathForCell(cell) {

                desController.book = bookArray[indexPath.row]
            }
        }
    }

    @IBAction func createBook(sender: AnyObject) {
        performSegueWithIdentifier("ShowDataForm", sender: sender)
    }
}

extension DataViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)

        cell.textLabel?.text = bookArray[indexPath.row].name
        cell.detailTextLabel?.text = bookArray[indexPath.row].author

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sender = tableView.cellForRowAtIndexPath(indexPath)

        performSegueWithIdentifier("ShowDataForm", sender: sender)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            managedObjectContext.deleteObject(bookArray[indexPath.row])
            appDelegate.saveContext()
            bookArray.removeAtIndex(indexPath.row)
        }
    }
    
}