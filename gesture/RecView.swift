//
//  RecView.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/24.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class RecView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch in touches {
            let point = touch.locationInView(self.superview)
            self.center = point
        }
    }
}
