//
//  RecipeDetailViewController.swift
//  iRecipe
//
//  Created by Ricardo Casanova on 11/02/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import WebKit

class RecipeDetailViewController: BaseViewController {
    
    public var presenter: RecipeDetailPresenterDelegate?
    
    private let customTitleView: CustomTitleView = CustomTitleView()
    private var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        presenter?.viewDidLoad()
    }
    
}

// MARK: - Setup views
extension RecipeDetailViewController {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .gray()
        edgesForExtendedLayout = []
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        // Create a WKWebView and add it to the view
        webView = WKWebView()
//        webView?.navigationDelegate = self
        webView?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white()
        customTitleView.setTitle("Recipe detail")
        customTitleView.subtitleColor = .white()
        customTitleView.setSubtitle("Recipe Puppy©")
        navigationItem.titleView = customTitleView
    }
    
    func loadWebViewWithUrl(_ url: URL) {
        var langStr: String?
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        if #available(iOS 10.0, *) {
            langStr = Locale.current.languageCode
        } else {
            langStr = Locale.preferredLanguages[0]
        }
        request.setValue(langStr, forHTTPHeaderField: "accept-language")
        webView?.load(request as URLRequest)
    }
    
}

// MARK: - Layout & constraints
extension RecipeDetailViewController {
    
    private struct Layout {
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        guard let webView = webView else {
            return
        }
        
        view.addSubview(webView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: webView)
        view.addConstraintsWithFormat("V:|[v0]|", views: webView)
    }
    
}

// MARK: WKWebView navigation delegate
//extension RecipeDetailViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        showLoader(true)
//    }
//
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        showLoader(false)
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        showLoader(false)
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        showLoader(false)
//    }
//
//}

extension RecipeDetailViewController: RecipeDetailViewInjection {
    
    func loadUrl(_ url: URL) {
        loadWebViewWithUrl(url)
    }
    
}
