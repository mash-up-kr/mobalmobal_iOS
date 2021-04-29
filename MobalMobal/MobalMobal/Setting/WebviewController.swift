//
//  WebviewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/10.
//

import UIKit
import WebKit

class WebviewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    // MARK: - Properties
    var webURL: String?
    var navTitle: String?
    private var webView: WKWebView?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setwebView()
        setURLRequest()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    // MARK: - Methods
    private func setwebView() {
        self.view = webView
        webView = WKWebView(frame: .zero)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.backgroundColor = .backgroundColor
        webView?.isOpaque = false
    }
    
    private func setURLRequest() {
        guard let webURL = self.webURL else { return }
        guard let url: URL = URL(string: webURL) else { return }
        let request: URLRequest = URLRequest(url: url)
        webView?.load(request)
        
    }
    
    private func setNavigationBar() {
        self.title = navTitle
        self.navigationController?.navigationBar.tintColor = .white
    }
}
