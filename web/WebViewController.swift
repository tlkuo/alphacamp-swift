//
//  WebViewViewController.swift
//  web
//
//  Created by martin on 2016/4/1.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: UIView!
    
    var wkWebView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Safari
//        let url = NSURL(string: "https://www.google.com")
//        UIApplication.sharedApplication().openURL(url!)

        // WKWebView
        wkWebView = WKWebView(frame: webView.bounds)
        webView.addSubview(wkWebView!)
        
        let url = NSURL(string: "https://www.google.com")
        let req = NSURLRequest(URL: url!)
        
        wkWebView?.loadRequest(req)
    }
    
    override func viewDidAppear(animated: Bool) {
        // SFSafariViewController
//        let url = NSURL(string: "https://www.google.com")
//        let controller = SFSafariViewController(URL: url!)
//        
//        presentViewController(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backWebView(sender: AnyObject) {
        wkWebView?.goBack()
    }

}

