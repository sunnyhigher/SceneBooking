//
//  HD_WebView.swift
//  FRDIntent
//
//  Created by 波 on 2018/3/26.
//

import UIKit
import WebKit
protocol HD_WebVCDelegate : NSObjectProtocol {
    func webViewIsCanScroll(_ willOffset :CGFloat)-> Bool
}
class HD_WebVC: HD_BaseVC {
    weak var delegate : HD_WebVCDelegate?
    /// 网络url
    var url :String?
    /// 本地文件路径
    var filePath : String?
    var htmlStr : String? {
        didSet {
            webView?.loadHTMLString(htmlStr!, baseURL: nil)
            view.addSubview(webView!)
        }
    }
    ///是否设置navibar的标题
    var isShowTitle : Bool = false
    
    var webView :WKWebView?
    
    lazy var progressV :UIProgressView = {
        let tep = UIProgressView()
        view.addSubview(tep)
        tep.isHidden = true
        return tep
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        let configuration = WKWebViewConfiguration()
        let userController = WKUserContentController()
        configuration.userContentController = userController
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView?.scrollView.delegate = self
        webView?.navigationDelegate = self
        webView?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeBottom, right: 0)
        self.automaticallyAdjustsScrollViewInsets = false
        adaptScrollViewAdjust((webView?.scrollView)!)
        userController.add(self, name: "")
        
        if url != nil && url != "" {
            webView?.load(URLRequest(url: URL(string: url!)!))
            view.addSubview(webView!)
            
        } else if filePath != nil && filePath != "" {
            do{
                let htmlString = try String.init(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
                
                
                webView?.loadHTMLString(htmlString, baseURL: nil)
                view.addSubview(webView!)
                
            }catch{
            }
            
        } else if htmlStr != nil && htmlStr != "" {
            webView?.loadHTMLString(htmlStr!, baseURL: nil)
            view.addSubview(webView!)

        }
        
    }
    override func viewWillLayoutSubviews(){
        webView?.frame = self.view.bounds

        
    }
    
    deinit {
        webView?.scrollView.delegate = nil
    }
}


extension HD_WebVC : WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showError("加载失败")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isShowTitle == true {
            self.navigationItem.title = self.webView?.title;
        }
        hidenLoading()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoading()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString
        print(url ?? "")
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        HDlog(navigationResponse.response.url)
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    
    
}



extension HD_WebVC :UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if delegate?.webViewIsCanScroll(scrollView.contentOffset.y) == false  {
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}
