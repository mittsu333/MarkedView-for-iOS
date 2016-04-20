//
//  WKMarkedController.swift
//
//  Created by mittsu on 2016/04/19.
//

import UIKit
import MarkedView

class WKMarkedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "md")!
        guard let data = NSData(contentsOfFile: path) else {
            return
        }
        let contents = String(NSString(data: data, encoding: NSUTF8StringEncoding)!)
        
        let wkWebView = WKMarkedView()
        self.view = wkWebView        
        wkWebView.textToMark(contents)
    }
    
}
