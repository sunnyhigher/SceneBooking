//
//  HD_DetailViewController.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/22.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_DetailViewController: HD_BaseVC {

    lazy var webView: UIWebView = {
        let webView = UIWebView()
        return webView
    }()
    
    var urlStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(0)
        }
        self.navigationItem.title = "详情"
        let url = URL(string: urlStr)!
        webView.loadRequest(URLRequest(url: url) as URLRequest)
        webView.delegate = self
    }
}

extension HD_DetailViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        showLoading()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hidenLoading()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let pathStr = request.url?.absoluteString
        if pathStr?.contains("&type=") ?? false {
            showText("暂不支持分享功能")
        }
        return true
    }
}
