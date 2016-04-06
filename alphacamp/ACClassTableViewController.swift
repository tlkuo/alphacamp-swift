//
//  ACClassTableViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/1.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ACClassTableViewController: UITableViewController {

    var classHandler: ACClassHandler?
    var classArray: [ACClass] = []
    var classIndex = 0
    var authToken: String?

    var acCourse: ACCourse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        authToken = NSUserDefaults.standardUserDefaults().stringForKey("auth_token")

        guard let token = authToken else {
            showLoginPage()
            return
        }

        classHandler = ACClassHandler(delegate: self)
        classHandler?.getClasses(token)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectClass(index: Int) {

        guard index >= 0 && index < classArray.count else {
            return
        }

        guard let token = authToken else {
            showLoginPage()
            return
        }

        classIndex = index

        let acClass = classArray[index]

        if acClass.courses == nil {
            classHandler?.getCourses(token, id: acClass.id)
        } else {
            tableView.reloadData()
        }
    }

    func showLoginPage() {
        // TODO: show login page
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return acCourse?.lessons?.count > 0 || classArray.count > 0 ? 1 : 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if acCourse != nil {
            return acCourse?.lessons?.count ?? 0
        }

        if classArray.count > 0 {
            return classArray[classIndex].courses?.count ?? 0
        }

        return 0
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return acCourse != nil ? (acCourse?.name) : classArray[classIndex].name
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath)

        if acCourse != nil {
            cell.textLabel?.text = acCourse?.lessons?[indexPath.row].name
        } else {
            cell.textLabel?.text = classArray[classIndex].courses?[indexPath.row].name
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "ShowLessons" {

            if let destController = segue.destinationViewController as? ACClassTableViewController,
                indexPath = tableView.indexPathForSelectedRow {

                destController.acCourse = classArray[classIndex].courses?[indexPath.row]
            }
        }
        else if segue.identifier == "ShowLessonDetail" {

            if let destController = segue.destinationViewController as? ACClassDetailViewController,
                indexPath = tableView.indexPathForSelectedRow,
                url = acCourse?.lessons?[indexPath.row].url {

                destController.url = NSURL(string: url)
            }
        }
    }
}

extension ACClassTableViewController: ACClassDelegate {

    func getClassesSuccess(classes: [ACClass]) {
        classArray = classes

        dispatch_async(dispatch_get_main_queue()) { 
            self.selectClass(0)
        }
    }

    func getClassesFail() {

    }

    func getCoursesSuccess(id: String, courses: [ACCourse]) {
        let index = classIndex

        if classArray[index].id == id {
            classArray[index].courses = courses

            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

    func getCoursesFail() {

    }
}
