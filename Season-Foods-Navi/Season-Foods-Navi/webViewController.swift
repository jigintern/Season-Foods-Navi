//
//  webViewController.swift
//  Season-Foods-Navi
//
//  Created by 洞井僚太 on 2019/09/06.
//  Copyright © 2019 洞井僚太. All rights reserved.
//

import Foundation
import WebKit
import UIKit


class webViewController:UIViewController{
  //  @IBOutlet weak var webView: WKWebView!
    var webView: WKWebView = WKWebView()

    /*  override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
 //       webView.uiDelegate = self
        view = webView
    }*/
    var targetUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.view.frame, configuration: webConfiguration)
        // webView.frame = self.view.frame
        //let targetUrl = recipiInfo.howto
        let urlRequest = URLRequest(url:URL(string:targetUrl)!)
        webView.load(urlRequest)
        self.view.addSubview(webView)
      /*  webView = WKWebView(frame:CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        view.addSubview(webView)
        let url = URL(string:targetUrl)
        let urlRequest =
        // 画面いっぱいに表示
        //self.setLayoutFullScreenWebView(webView: webView, view: view)
        
        //webView.navigationDelegate = self
        
        //requestUrl(urlString: targetUrl, webView: self.webView)*/
    }
}
extension webViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
extension webViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
}
