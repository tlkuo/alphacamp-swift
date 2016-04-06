//
//  ACClassDetailViewController.swift
//  alphacamp-swift
//
//  Created by martin on 2016/4/1.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit
import WebKit

class ACClassDetailViewController: UIViewController {

    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))

        view.addSubview(webView)
        
        if let url = self.url {
            webView.loadRequest(NSURLRequest(URL: url))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
