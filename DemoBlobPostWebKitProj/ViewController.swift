//
//  ViewController.swift
//  DemoBlobPostWebKitProj
//
//  Created by [User] on 12/14/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    private lazy var sampleSchemeHandler = SampleSchemeHandler()

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        let configuration = WKWebViewConfiguration()

        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")

        configuration.setURLSchemeHandler(sampleSchemeHandler, forURLScheme: "sample")

        webView.navigationDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        let htmlFileContent = try! String(contentsOfFile: Bundle.main.path(forResource: "sample", ofType: "html")!)
        let sampleSchemeURL = URL(string: "sample://upload")!
        webView.loadHTMLString(htmlFileContent, baseURL: sampleSchemeURL)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
