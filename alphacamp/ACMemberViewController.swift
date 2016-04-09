//
//  ACMemberViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/1.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ACMemberViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var memberScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    var memberManager: ACMemberManager?
    var groups: [ACGroup: [String]] = [:]
    var members: [String: ACMember] = [:]
    var membersView: [Int: ACMemberView] = [:]
    var authToken: String?
    var currentGroup: ACGroup = .ACStaffGroup

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memberManager = ACMemberManager(delegate: self)
        memberManager?.getMembers(.ACStaffGroup)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadScrollView() {
        let width = memberScrollView.frame.width
        let height = memberScrollView.frame.height

        removeScrollViewPages()

        loadScrollViewWithPage(0)
        loadScrollViewWithPage(1)

        if let groupMember = groups[currentGroup] {
            memberScrollView.contentSize = CGSize(width: width * CGFloat(groupMember.count), height: height)
            pageControl.numberOfPages = groupMember.count
        }

        memberScrollView.reloadInputViews()
    }

    @IBAction func segmentedControlAction(sender: AnyObject) {

        let index = segmentedControl.selectedSegmentIndex

        guard let group = ACGroup(rawValue: index) else {
            return
        }

        currentGroup = group

        if groups[group] == nil {
            memberManager?.getMembers(group)
        } else {
            reloadScrollView()
        }
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

extension ACMemberViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let page = Int(floor((offsetX - width / 2) / width) + 1)

        loadScrollViewWithPage(page - 1)
        loadScrollViewWithPage(page)
        loadScrollViewWithPage(page + 1)

        removeScrollViewWithPage(page - 2)
        removeScrollViewWithPage(page + 2)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.frame.width

        pageControl.currentPage = Int(offsetX / width)
    }

    func loadScrollViewWithPage(page: Int) {

        guard membersView[page] == nil else {
            return
        }

        guard let groupMember = groups[currentGroup] else {
            return
        }

        guard page >= 0 && page < groupMember.count else {
            return
        }

        let id = groupMember[page]

        guard let member = members[id] else {
            memberManager?.getMember(id)
            return
        }

        if let memberView = UINib(nibName: "ACMemberView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? ACMemberView {

            membersView[page] = memberView

            let width = memberScrollView.frame.width
            let height = memberScrollView.frame.height

            memberView.frame = CGRect(x: width * CGFloat(page), y: 0, width: width, height: height)
            memberView.nameLabel.text = member.getFullName()
            memberView.introductionLabel.text = member.introduction
            memberScrollView.addSubview(memberView)
        }
    }

    func removeScrollViewWithPage(page: Int) {

        guard let view = membersView[page] else {
            return
        }

        view.imageView.image = nil
        view.removeFromSuperview()
        membersView[page] = nil
    }

    func removeScrollViewPages() {

        for (_, view) in membersView {
            view.imageView.image = nil
            view.removeFromSuperview()
        }

        membersView = [:]
        memberScrollView.contentSize = CGSizeZero
        pageControl.numberOfPages = 0
    }
}

extension ACMemberViewController: ACMemberDelegate {

    func getMembersSuccess(group: ACGroup, members: [String]) {

        self.groups[group] = members

        dispatch_async(dispatch_get_main_queue()) {

            if self.currentGroup == group {
                self.reloadScrollView()
            }
        }
    }

    func getMembersFail(group: ACGroup) {

    }
    
    func getMemberSuccess(id: String, member: ACMember) {

        self.members[id] = member

        dispatch_async(dispatch_get_main_queue()) { 

            if let groupMember = self.groups[self.currentGroup],
                page = groupMember.indexOf(id) {

                self.loadScrollViewWithPage(page)
            }
        }
    }

    func getMemberFail(id: String) {

    }
}
