//
//  webPageViewController.swift
//  AsgmntApp
//
//  Created by Jigar on 28/07/18.
//  Copyright © 2018 Jigar. All rights reserved.
//

import Foundation
import UIKit
import WebKit



//http://en.wikipedia.org/?curid=18630637

class webPageViewController:  UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var webPagTitle: UILabel?
    var stringURL : String? ;
    var strTitle : String? ;
    @IBOutlet weak var myWebView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView?.navigationDelegate = self
        webPagTitle?.text = strTitle;
        // Do any additional setup after loading the view, typically from a nib.
        if let stringURL = stringURL {
            let url = URL (string: stringURL);
            let request = URLRequest(url: url!);
            myWebView?.load(request);
            loadingActivity.isHidden  = false;
            loadingActivity.startAnimating();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButtonTouched(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivity.stopAnimating()
        loadingActivity.isHidden  = true;
    }
}
