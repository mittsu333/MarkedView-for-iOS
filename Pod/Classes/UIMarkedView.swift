//
//  UIMarkedView.swift
//  Markdown preview for UIWebView
//
//  Created by mittsu on 2016/04/19.
//

import UIKit

public class UIMarkedView: UIView {

    @IBOutlet weak var uiMarkedView: UIWebView!
        
    private var mdContents: String?
    private var codeScrollDisable = false
    
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
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "UIMarkedView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        addSubview(view)
        
        // The size of the custom View to the same size as himself
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))

        guard let mdView = uiMarkedView else { return }

        mdView.delegate = self
        
        // hide background
        mdView.backgroundColor = UIColor.clearColor()
        mdView.stringByEvaluatingJavaScriptFromString(
            "document.documentElement.style.webkitTouchCallout = 'none';"
        )
        
        // load local HTML file
        let path = bundle.pathForResource("MarkedView.bundle/md_preview", ofType:"html")
        let requestHtml = NSURLRequest(URL: NSURL.fileURLWithPath(path!))
        mdView.loadRequest(requestHtml)
    }
    
    /**
     Load from markdown file
     
     - parameter filePath: markdown file path
     */
    public func loadFile(filePath: String?) {
        guard let mdData = NSData(contentsOfFile: filePath!) else {
            return
        }
        textToMark(String().data2String(mdData))
    }
    
    /**
     To set the text to display
     
     - parameter mdText: markdown text
     */
    public func textToMark(mdText: String?) {
        guard let contents = mdText else {
            return
        }
        mdContents = toMarkdownFormat(contents)
    }
    
    private func toMarkdownFormat(contents: String) -> String {
        let conversion = ConversionMDFormat();
        let imgChanged = conversion.imgToBase64(contents)
        return conversion.escapeForText(imgChanged)
    }
    
    
    /** option **/

    public func setCodeScrollDisable() {
        codeScrollDisable = true
    }
    
}

// MARK: - <#UIWebViewDelegate#>
extension UIMarkedView: UIWebViewDelegate {
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        
        guard let contents = mdContents, let mdView = uiMarkedView else {
            return;
        }
        
        let script = "preview('\(contents)', \(codeScrollDisable));"
        mdView.stringByEvaluatingJavaScriptFromString(script)
    }
    
}
