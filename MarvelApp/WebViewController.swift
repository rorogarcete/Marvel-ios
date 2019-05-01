//
//  WebViewController.swift
//  Marvel-Swift-MVVM
//
//  Created by Felipe Silva  on 4/6/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//
import WebKit
import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var url:Url?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        self.title = url?.type
        navItem.title = url?.type

        openWebSite()
    }

    
    @IBAction func close(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        dismiss(animated: true, completion: nil)
    }


    private func openWebSite(){
        let requestURL = NSURL(string: url?.url ?? "")
        let request = URLRequest(url: requestURL! as URL)
        webView.loadRequest(request)
    }

    
}

extension WebViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

}
