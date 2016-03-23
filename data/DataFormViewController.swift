//
//  DataFormViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/23.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit
import CoreData

class DataFormViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let book = self.book {
            nameField.text = book.name
            authorField.text = book.author
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitForm(sender: AnyObject) {
        
        defer {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        if let controller = presentingViewController as? DataViewController {
            
            guard let book = self.book ?? NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: controller.managedObjectContext) as? Book else {
                return
            }

            book.name = nameField.text
            book.author = authorField.text

            controller.appDelegate.saveContext()
        }
    }

    @IBAction func stopInput(sender: AnyObject) {
        resignFirstResponder()
    }
}
