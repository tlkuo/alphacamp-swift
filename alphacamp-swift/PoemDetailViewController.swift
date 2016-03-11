//
//  PoemDetailViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/10.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class PoemDetailViewController: UIViewController {
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var poem: Poets.Poem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let poem = self.poem {
            navTitle.title = poem.title
            contentLabel.text = poem.content
            descriptionLabel.text = poem.description
        }
    }
}
