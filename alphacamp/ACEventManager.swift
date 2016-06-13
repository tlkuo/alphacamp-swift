//
//  ACEventManager.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/4.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

struct ACEvent {
    let title: String
    let date: String
    let description: String
    let image: String
    let url: String
    
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.date = json["date"].stringValue
        self.description = json["description"].stringValue
        self.image = json["image"].stringValue
        self.url = json["url"].stringValue
    }
}

protocol ACEventDelegate: class {
    func getEventsSuccess(events: [ACEvent])
    func getEventsFail()
}

class ACEventManager {

    weak var delegate: ACEventDelegate?
    
    init(delegate: ACEventDelegate) {
        self.delegate = delegate
    }

    // Event list will response through ACEventDelegate
    func getEvents() {

        let rootRef = FIRDatabase.database().reference()
        let eventRef = rootRef.child("events")

        eventRef.observeSingleEventOfType(.Value,
            withBlock: { snapshot in

                guard !(snapshot.value is NSNull) else {
                    self.delegate?.getEventsFail()
                    return
                }

                var events: [ACEvent] = []
                
                for event in JSON(snapshot.value!).arrayValue {
                    events.append(ACEvent(json: event))
                }

                self.delegate?.getEventsSuccess(events)
            }
        )
    }
}
