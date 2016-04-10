//
//  ACMemberManager.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/8.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import Foundation
import Firebase

enum ACGroup: Int {
    case ACStaffGroup = 0
    case ACMentorGroup
    case ACAlumniGroup
}

struct ACMember {
    let firstName: String
    let lastName: String
    let avatar: String
    let introduction: String
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

protocol ACMemberDelegate: class {
    func getMembersSuccess(group: ACGroup, members: [String])
    func getMemberSuccess(id: String, member: ACMember)
    func getMembersFail(group: ACGroup)
    func getMemberFail(id: String)
}

class ACMemberManager {

    weak var delegate: ACMemberDelegate?

    init(delegate: ACMemberDelegate) {
        self.delegate = delegate
    }

    func getMembers(group: ACGroup) {
        let rootRef = Firebase(url: "https://alphacamp-frb.firebaseio.com")
        var groupRef = rootRef.childByAppendingPath("groups")

        switch group {
        case .ACStaffGroup:
            groupRef = groupRef.childByAppendingPath("staff")
        case .ACMentorGroup:
            groupRef = groupRef.childByAppendingPath("mentor")
        case .ACAlumniGroup:
            groupRef = groupRef.childByAppendingPath("alumni")
        }

        groupRef
        .childByAppendingPath("members")
        .observeSingleEventOfType(.Value, withBlock: {
            snapshot in
            
            if let membersDic = snapshot.value as? [String: AnyObject] {

                var members: [String] = []

                for (mID, _) in membersDic {
                    members.append(mID)
                }

                self.delegate?.getMembersSuccess(group, members: members.sort())
            } else {
                self.delegate?.getMembersFail(group)
            }
        })
    }
    
    func getMember(id: String) {
        let rootRef = Firebase(url: "https://alphacamp-frb.firebaseio.com")
        let memberRef = rootRef.childByAppendingPath("members/\(id)")
        
        memberRef.observeSingleEventOfType(.Value, withBlock: {
            snapshot in

            if let memberDic = snapshot.value as? [String: String] {

                let member = ACMember(
                    firstName: memberDic["firstName"] ?? "",
                    lastName: memberDic["lastName"] ?? "",
                    avatar: memberDic["avatar"] ?? "",
                    introduction: memberDic["introduction"] ?? ""
                )

                self.delegate?.getMemberSuccess(id, member: member)
            } else {

                self.delegate?.getMemberFail(id)
            }
        })
    }
}
