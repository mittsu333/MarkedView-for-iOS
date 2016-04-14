//
//  UIMarkedView.swift
//  Markdown preview for UIWebView
//
//  Created by mittu on 2016/02/21.
//  Copyright © 2016年 mittu. All rights reserved.
//

import UIKit

public class UIMarkedView: UIView {

    @IBOutlet weak var uiMarkedView: UIWebView!
        
    private var mdContents: String?
    
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
//        let path = NSBundle.mainBundle().pathForResource("md_preview", ofType:"html")
        let path = NSBundle.mainBundle().pathForResource("MarkedView", ofType:"bundle")
        let requestHtml = NSURLRequest(URL: NSURL.fileURLWithPath(path!))
        mdView.loadRequest(requestHtml)
    }
    
    
    /**
     To set the text to display
     
     - parameter mdText: markdown text
     */
    public func toRepresentation(mdText: String?) {
        mdContents = mdText
    }

}

// MARK: - <#UIWebViewDelegate#>
extension UIMarkedView: UIWebViewDelegate {
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        
        guard let contents = mdContents, let mdView = uiMarkedView else {
            return;
        }
        
        // To escape to handle \n and ' in the script
        var escText = contents.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
        escText = escText.stringByReplacingOccurrencesOfString("'", withString: "\\'")
        
        let script = "preview('\(escText)');"
        mdView.stringByEvaluatingJavaScriptFromString(script)
    }
    
}
