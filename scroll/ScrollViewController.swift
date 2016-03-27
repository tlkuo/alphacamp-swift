//
//  ScrollViewController.swift
//  scroll
//
//  Created by martin on 2016/3/27.
//  Copyright © 2016年 Frainbow. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var pageView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let imageSpace = 10
    let images: [String] = [
        "http://i.istockimg.com/file_thumbview_approve/83477921/6/stock-photo-83477921-i-am-waiting-for-you.jpg",
        "http://i.istockimg.com/file_thumbview_approve/58013110/6/stock-photo-58013110-lovely-little-kitten-exploring-world.jpg",
        "http://i.istockimg.com/file_thumbview_approve/78175339/6/stock-photo-78175339-bengali-bird.jpg",
        "http://i.istockimg.com/file_thumbview_approve/69764945/6/stock-photo-69764945-dogs-playing.jpg",
        "http://i.istockimg.com/file_thumbview_approve/53574160/6/stock-photo-53574160-labrador-retriever-puppy.jpg",
        "http://i.istockimg.com/file_thumbview_approve/63497489/6/stock-photo-63497489-golden-retriever-dog-cold.jpg",
        "http://i.istockimg.com/file_thumbview_approve/81213851/6/stock-photo-81213851-english-setter-puppy-with-a-chewing-bone-norway.jpg",
        "http://i.istockimg.com/file_thumbview_approve/69930947/6/stock-photo-69930947-closeup-of-a-dog-with-glasses.jpg",
        "http://i.istockimg.com/file_thumbview_approve/52891456/6/stock-photo-52891456-party-dog.jpg",
        "http://i.istockimg.com/file_thumbview_approve/85364947/6/stock-photo-85364947-golden-retriever-dog-giving-paw-owner-closeup-photo.jpg"]
    
    var zoomViews = [Int: UIScrollView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let pageWidth = pageView.frame.size.width
        let pageHeight = pageView.frame.size.height

        pageView.contentSize = CGSize(width: pageWidth * CGFloat(images.count), height: pageHeight)

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0

        loadScrollViewWithPage(0)
        loadScrollViewWithPage(1)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        guard scrollView !== self.pageView else {
            return nil
        }

        return scrollView.subviews.first
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        guard scrollView === self.pageView else {
            return
        }

        let pageWidth = scrollView.frame.size.width
        let offset = scrollView.contentOffset
        let page = Int(offset.x / pageWidth)

        pageControl.currentPage = page
        
        zoomViews[page - 1]?.zoomScale = 1
        zoomViews[page + 1]?.zoomScale = 1
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        guard scrollView === self.pageView else {
            return
        }

        let pageWidth = scrollView.frame.size.width
        let offset = scrollView.contentOffset
        let page = Int(floor((offset.x - pageWidth / 2) / pageWidth) + 1)
        
        loadScrollViewWithPage(page - 1)
        loadScrollViewWithPage(page)
        loadScrollViewWithPage(page + 1)
        
        removeScrollViewWithPage(page + 2)
        removeScrollViewWithPage(page - 2)
    }

    func loadScrollViewWithPage(page: Int) {

        guard page >= 0 && page < images.count && zoomViews[page] == nil else {
            return
        }

        let pageWidth = pageView.frame.size.width
        let pageHeight = pageView.frame.size.height
        let data = NSData(contentsOfURL: NSURL(string: images[page])!)
        let zoomView = UIScrollView(frame: CGRect(
                x: pageWidth * CGFloat(page) + CGFloat(imageSpace / 2), y: 0,
                width: pageWidth - CGFloat(imageSpace), height: pageHeight))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                width: pageWidth - CGFloat(imageSpace), height: pageHeight))

        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(data: data!)

        zoomView.maximumZoomScale = 2
        zoomView.delegate = self
        zoomView.addSubview(imageView)
        
        pageView.addSubview(zoomView)
        zoomViews[page] = zoomView
    }
    
    func removeScrollViewWithPage(page: Int) {

        guard page >= 0 && page < images.count && zoomViews[page] != nil else {
            return
        }
        
        if let zoomView = zoomViews[page] {
            if let imageView = zoomView.subviews.first as? UIImageView {
                imageView.image = nil
                imageView.removeFromSuperview()
            }
            zoomView.removeFromSuperview()
        }

        zoomViews[page] = nil
    }

}

