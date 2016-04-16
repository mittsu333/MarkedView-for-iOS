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
        
        let vc = MainViewController()
        
        let mdView = UIMarkedView()
        self.view = mdView
        mdView.toRepresentation(vc.dummyContents)
        
    }
    
}
