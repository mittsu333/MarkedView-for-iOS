//
//  WKMarkedView.swift
//  Markdown preview for WKWebView
//
//  Created by mittu on 2016/02/21.
//  Copyright © 2016年 mittu. All rights reserved.
//

import UIKit
import WebKit

public class WKMarkedView: UIView {
    
    private var webView: WKWebView!
    private var mdContents: String?
    private var requestHtml: NSURLRequest?

    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        initView()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("MarkedView.bundle/md_preview", ofType:"html")
        requestHtml = NSURLRequest(URL: NSURL.fileURLWithPath(path!))
        
        // Disables pinch to zoom
        let source: String = "var meta = document.createElement('meta');"
            + "meta.name = 'viewport';"
            + "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';"
            + "var head = document.getElementsByTagName('head')[0];"
            + "head.appendChild(meta);"
            + "document.documentElement.style.webkitTouchCallout = 'none';";
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        
        // Create the configuration
        let userContentController = WKUserContentController()
        userContentController.addUserScript(script)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        webView = WKWebView(frame: self.frame, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        addSubview(webView)
        
        // The size of the custom View to the same size as himself
        let bindings = ["view": webView]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        
        // Hide background
        webView.backgroundColor = UIColor.clearColor()
    }
    
    /**
     To set the text to display
     
     - parameter mdText: markdown text
     */
    public func toRepresentation(mdText: String?) {
        guard let url = requestHtml else {
            return;
        }
        mdContents = mdText
        webView.loadRequest(url)
    }

}

// MARK: - <#WKNavigationDelegate#>
extension WKMarkedView: WKNavigationDelegate {
    
    public func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
            
        guard let contents = mdContents else {
            return;
        }
        
        // To escape to handle \n and ' in the script
        var escText = contents.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
        escText = escText.stringByReplacingOccurrencesOfString("'", withString: "\\'")
        
        let script = "preview('\(escText)');"
        webView.evaluateJavaScript(script, completionHandler: { (html, error) -> Void in } )
    }
    
}

