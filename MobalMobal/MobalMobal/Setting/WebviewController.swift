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
    
    private var webView: WKWebView?
    // 임시로 개인정보처리 링크 넣음
    private let openSourceURL: String = "https://www.notion.so/b384c72d60cc4475af49284625f81a0e"
    private let termsAndConditionURL: String =  "https://www.notion.so/26c36382cd8448188c7532519b9019cc"
    private let openKakaoTalkURL: String = "https://open.kakao.com/o/sRo0Df7c"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndConditionButtonAction()
        self.view.backgroundColor = .backgroundColor
        setwebView()
    }
    func setwebView() {
        self.view = webView
        webView = WKWebView(frame: self.view.frame)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
    }

    func openSourceButtonAction() {
        guard let request: URLRequest = setURLRequest(to: openSourceURL) else { return }
        webView?.load(request)
    }
    private func setURLRequest(to url: String) -> URLRequest? {
        guard let url: URL = URL(string: url) else { return nil }
        let request: URLRequest = URLRequest(url: url)
        return request
    }
    func termsAndConditionButtonAction() {
        guard let request: URLRequest = setURLRequest(to: termsAndConditionURL) else { return }
        webView?.load(request)
    }
 
    func inquiryButtonAction() {
        guard let request: URLRequest = setURLRequest(to: openKakaoTalkURL) else { return }
        webView?.load(request)
    }
}
