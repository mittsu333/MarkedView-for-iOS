//
//  UIMarkedController.swift
//
//  Created by mittsu on 2016/04/19.
//

import UIKit
import MarkedView

class UIMarkedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("sample", ofType: "md")!

        let mdView = UIMarkedView()
        self.view = mdView
        mdView.loadFile(path)        
    }
    
}
