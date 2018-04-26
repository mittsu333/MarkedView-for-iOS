//
//  WKMarkedController.swift
//
//  Created by mittsu on 2016/04/19.
//

import UIKit
import SafariServices

import MarkedView

class WKMarkedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "sample", ofType: "md")!
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return
        }
        let contents = String(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
        
        let wkWebView = WKMarkedView()
        wkWebView.delegate = self
        
        // code block in scrolling be deactivated.
        // wkWebView.setCodeScrollDisable()
        
        self.view = wkWebView        
        wkWebView.textToMark(contents)
    }
    
}

extension WKMarkedController: WKMarkViewDelegate {
    func markViewRedirect(url: URL) {

        if #available(iOS 9.0, *) {
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true, completion: nil)

        } else {
            if(UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

