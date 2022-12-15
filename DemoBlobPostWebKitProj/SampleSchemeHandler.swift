//
//  SampleSchemeHandler.swift
//  DemoBlobPostWebKitProj
//
//  Created by [User] on 12/14/22.
//

import WebKit

struct SampleResponse: Codable {
    let status: String
    let message: String
}

class SampleSchemeHandler: NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        let url = urlSchemeTask.request.url!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [
            "Access-Control-Allow-Origin": "*"
        ])!

        let sampleResponse = SampleResponse(status: "success", message: "Sample message")
        let data = try! JSONEncoder().encode(sampleResponse)

        urlSchemeTask.didReceive(response)
        urlSchemeTask.didReceive(data)
        urlSchemeTask.didFinish()
    }

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {}

    deinit {}
}
