//
//  WKWebSampleMarkedView.swift
//  GravBlog
//
//  Created by mittu on 2016/03/05.
//  Copyright © 2016年 takeshi tokumitsu. All rights reserved.
//

import UIKit
import MarkedView

class WKWebSampleMarkedView: UIViewController {
    
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
