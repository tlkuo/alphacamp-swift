//
//  ACEventViewController.swift
//  alphacamp
//
//  Created by martin on 2016/3/21.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit
import SDWebImage

class ACEventViewController: UIViewController {
    @IBOutlet weak var eventTable: UITableView!

    var eventManager: ACEventManager?
    var eventArray: [ACEvent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        eventTable.rowHeight = UITableViewAutomaticDimension
        eventTable.estimatedRowHeight = 50
        
        eventManager = ACEventManager(delegate: self)
        eventManager?.getEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "ShowEventDetail" {

            var view: UIView? = sender?.superview

            while !(view is UITableViewCell) {
                view = view?.superview
            }

            if let destController = segue.destinationViewController as? ACEventDetailViewController,
                eventCell = view as? UITableViewCell,
                indexPath = eventTable.indexPathForCell(eventCell) {

                destController.url = NSURL(string: eventArray[indexPath.row].url)
            }
        }
    }

    @IBAction func showEventDetail(sender: AnyObject) {
        performSegueWithIdentifier("ShowEventDetail", sender: sender)
    }
}

extension ACEventViewController: ACEventDelegate {

    func getEventsSuccess(events: [ACEvent]) {
        eventArray = events
        eventTable.reloadData()
    }

    func getEventsFail() {

    }
}

extension ACEventViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)
        let event = eventArray[indexPath.row]

        if let eventCell = cell as? ACEventTableViewCell {

            eventCell.eventImage.image = nil
            eventCell.eventTitle.text = event.title
            eventCell.eventDate.text = event.date
            eventCell.eventDescription.text = event.description
            
            if let url = NSURL(string: event.image) {
                eventCell.eventImage.sd_setImageWithURL(url)
            }
        }

        return cell
    }
}
