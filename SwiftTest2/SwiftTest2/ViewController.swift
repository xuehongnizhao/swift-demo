//
//  ViewController.swift
//  SwiftTest2
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 com.hongdingnet.www. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView:UIProgressView!
    var websites = ["baidu.com","apple.com"]
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"打开",style: .Plain, target: self, action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton,spacer,refresh]
        navigationController?.toolbarHidden = false
        
        let url = NSURL(string: "https://www."+websites[0])!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openTapped(){
        let ac = UIAlertController(title: "打开", message: nil,preferredStyle: .ActionSheet)
        
        for website in websites{
           ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "取消",style: .Default,handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }
    func openPage(action: UIAlertAction){
        let url = NSURL(string: "https://www." + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL!
        if let host = url.host {
            for website in websites {
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
        decisionHandler(.Cancel)
    }
}

