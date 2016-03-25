//
//  NetworkViewController.swift
//  network
//
//  Created by martin on 2016/3/25.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showImage()
        showImage2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showImage() {
        let url = NSURL(string: "http://www.apple.com/support/assets/images/products/ipad/hero_ipad_family_2015_2x.jpg")
        let data = NSData(contentsOfURL: url!)

        imageView.image = UIImage(data: data!)
    }
    
    func showImage2() {
        let url = NSURL(string: "http://res.cloudinary.com/hrscywv4p/image/upload/c_limit,f_auto,h_3000,q_80,w_1200/v1/271374/http_s3.amazonaws.com_feather-files-aviary-prod-us-east-1_f5da8ea5e_2015-03-12_723490bbf79e44a788f5cd2516fefd46_myvzle.jpg")
        let request = NSURLRequest(URL: url!, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 30)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.imageView2.image = UIImage(data: data!)
            })
        }
        
        task.resume()
    }
}

