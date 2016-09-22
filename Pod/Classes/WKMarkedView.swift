//
//  WKMarkedView.swift
//  Markdown preview for WKWebView
//
//  Created by mittsu on 2016/04/19.
//

import UIKit
import WebKit

open class WKMarkedView: UIView {
    
    fileprivate var webView: WKWebView!
    fileprivate var mdContents: String?
    fileprivate var requestHtml: URLRequest?
    fileprivate var codeScrollDisable = false

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
        let bundle = Bundle(for: WKMarkedView.self)
        let path = bundle.path(forResource: "MarkedView.bundle/md_preview", ofType:"html")
        requestHtml = URLRequest(url: URL(fileURLWithPath: path!))
        
        // Disables pinch to zoom
        let source: String = "var meta = document.createElement('meta');"
            + "meta.name = 'viewport';"
            + "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';"
            + "var head = document.getElementsByTagName('head')[0];"
            + "head.appendChild(meta);"
            + "document.documentElement.style.webkitTouchCallout = 'none';";
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
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
        let bindings: [String : UIView] = ["view": webView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        
        // Hide background
        webView.backgroundColor = UIColor.clear
    }
    
    /**
     Load from markdown file
     
     - parameter filePath: markdown file path
     */
    public func loadFile(_ filePath: String?) {
        guard let mdData = try? Data(contentsOf: URL(fileURLWithPath: filePath!)) else {
            return
        }
        textToMark(String().data2String(mdData))
    }
    
    /**
     To set the text to display
     
     - parameter mdText: markdown text
     */
    public func textToMark(_ mdText: String?) {
        guard let url = requestHtml, let contents = mdText else {
            return;
        }
        mdContents = toMarkdownFormat(contents)
        webView.load(url)
    }
    
    fileprivate func toMarkdownFormat(_ contents: String) -> String {
        let conversion = ConversionMDFormat();
        let imgChanged = conversion.imgToBase64(contents)
        return conversion.escapeForText(imgChanged)
    }
    
    
    /** option **/
    
    open func setCodeScrollDisable() {
        codeScrollDisable = true
    }
    
}

// MARK: - <#WKNavigationDelegate#>
extension WKMarkedView: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
        guard let contents = mdContents else {
            return;
        }
        let script = "preview('\(contents)', \(codeScrollDisable));"
        webView.evaluateJavaScript(script, completionHandler: { (html, error) -> Void in } )
    }
    
}

