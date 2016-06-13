//
//  ACMemberManager.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/8.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

enum ACGroup: Int {
    case ACStaffGroup = 0
    case ACMentorGroup
    case ACAlumniGroup
}

class ACMember {
    let id: String
    var initedInfo: Bool

    var firstName: String
    var lastName: String
    var avatar: String
    var introduction: String
    
    init(id: String) {
        self.id = id
        self.initedInfo = false
        self.firstName = ""
        self.lastName = ""
        self.avatar = ""
        self.introduction = ""
    }
    
    func setInfo(info: JSON) {
        self.initedInfo = true
        self.firstName = info["firstName"].stringValue
        self.lastName = info["lastName"].stringValue
        self.avatar = info["avatar"].stringValue
        self.introduction = info["introduction"].stringValue
    }

    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

protocol ACMemberDelegate: class {
    func getMembersByGroupSuccess(group: ACGroup, members: [ACMember])
    func getMembersByGroupFail(group: ACGroup)

    func getMemberInfoSuccess(member: ACMember)
    func getMemberInfoFail()
}

class ACMemberManager {

    weak var delegate: ACMemberDelegate?

    init(delegate: ACMemberDelegate) {
        self.delegate = delegate
    }

    func getMembersByGroup(group: ACGroup) {

        let rootRef = FIRDatabase.database().reference()
        var groupRef = rootRef.child("groups")

        switch group {
        case .ACStaffGroup:
            groupRef = groupRef.child("staff")
        case .ACMentorGroup:
            groupRef = groupRef.child("mentor")
        case .ACAlumniGroup:
            groupRef = groupRef.child("alumni")
        }

        groupRef
        .child("members")
        .observeSingleEventOfType(.Value, withBlock: { snapshot in

            var members: [ACMember] = []

            if let value = snapshot.value {
                for (id, _) in JSON(value) {
                    members.append(ACMember(id: id))
                }
            }
            
            self.delegate?.getMembersByGroupSuccess(group, members: members)
        })
    }
    
    func getMemberInfo(member: ACMember) {

        let rootRef = FIRDatabase.database().reference()
        let memberRef = rootRef.child("members/\(member.id)")

        memberRef.observeSingleEventOfType(.Value, withBlock: { snapshot in

            if let value = snapshot.value {
                member.setInfo(JSON(value))
            }

            self.delegate?.getMemberInfoSuccess(member)
        })
    }
}
