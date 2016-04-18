//
//  UIWebSampleMarkedView.swift
//
//  Created by mittu on 2016/02/22.
//  Copyright © 2016年 takeshi tokumitsu. All rights reserved.
//

import UIKit
import MarkedView

class UIWebSampleMarkedView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = NSBundle(forClass: self.dynamicType)

        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "md")!
        guard let data = NSData(contentsOfFile: path) else {
            return
        }
        let contents = String(NSString(data: data, encoding: NSUTF8StringEncoding)!)
        
        let mdView = UIMarkedView()
        self.view = mdView
        mdView.textToMark(contents)
        
//        // test
//        mdView.toMarked(path)
        
    }
    
}
