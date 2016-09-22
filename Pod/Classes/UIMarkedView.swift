//
//  UIMarkedView.swift
//  Markdown preview for UIWebView
//
//  Created by mittsu on 2016/04/19.
//

import UIKit

open class UIMarkedView: UIView {

    @IBOutlet weak var uiMarkedView: UIWebView!
        
    fileprivate var mdContents: String?
    fileprivate var codeScrollDisable = false
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView(){
        // Load UIMarkedView
        let bundle = Bundle(for: UIMarkedView.self)
        let nib = UINib(nibName: "UIMarkedView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        
        // The size of the custom View to the same size as himself
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))

        guard let mdView = uiMarkedView else { return }

        mdView.delegate = self
        
        // hide background
        mdView.backgroundColor = UIColor.clear
        mdView.stringByEvaluatingJavaScript(
            from: "document.documentElement.style.webkitTouchCallout = 'none';"
        )
        
        // load local HTML file
        let path = bundle.path(forResource: "MarkedView.bundle/md_preview", ofType:"html")
        let requestHtml = URLRequest(url: URL(fileURLWithPath: path!))
        mdView.loadRequest(requestHtml)
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
        guard let contents = mdText else {
            return
        }
        mdContents = toMarkdownFormat(contents)
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

// MARK: - <#UIWebViewDelegate#>
extension UIMarkedView: UIWebViewDelegate {
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        
        guard let contents = mdContents, let mdView = uiMarkedView else {
            return;
        }
        
        let script = "preview('\(contents)', \(codeScrollDisable));"
        mdView.stringByEvaluatingJavaScript(from: script)
    }
    
}
