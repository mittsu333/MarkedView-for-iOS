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
        
        let vc = MainViewController()
        
        let wkWebView = WKMarkedView()
        self.view = wkWebView        
        wkWebView.toRepresentation(vc.dummyContents)
    }
    
}
