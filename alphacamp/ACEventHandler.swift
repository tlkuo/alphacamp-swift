//
//  ACEventHandler.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/4.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Firebase

struct ACEvent {
    let title: String
    let date: String
    let description: String
    let image: String
    let url: String
}

protocol ACEventDelegate: class {
    func getEventsSuccess(events: [ACEvent])
    func getEventsFail()
}

class ACEventHandler {

    weak var delegate: ACEventDelegate?
    
    init(delegate: ACEventDelegate) {
        self.delegate = delegate
    }

    // Event list will response through ACEventDelegate
    func getEvents() {
        let rootRef = Firebase(url: "https://alphacamp-frb.firebaseio.com")
        let eventRef = rootRef.childByAppendingPath("events")

        eventRef.observeSingleEventOfType(.Value,
            withBlock: { snapshot in

                guard !(snapshot.value is NSNull) else {
                    self.delegate?.getEventsFail()
                    return
                }

                var events: [ACEvent] = []

                if let eventArray = snapshot.value as? NSArray {

                    for event in eventArray {

                        events.append(ACEvent(
                            title: (event.objectForKey("title") as? String) ?? "",
                            date: (event.objectForKey("date") as? String) ?? "",
                            description: (event.objectForKey("description") as? String) ?? "",
                            image: (event.objectForKey("image") as? String) ?? "",
                            url: (event.objectForKey("url") as? String) ?? ""))
                    }
                }

                self.delegate?.getEventsSuccess(events)
            }
        )
    }
}
