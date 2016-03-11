//
//  DetailViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/11.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

protocol DetailDelegate {
    func nameChanged(new_name: String)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scroreLabel: UILabel!
    
    var student: Student?
    var delegate: DetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.text = student?.name
        scroreLabel.text = String(student!.score)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        delegate?.nameChanged(nameTextField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
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
