//
//  UIMarkedController.swift
//
//  Created by mittsu on 2016/04/19.
//

import UIKit
import SafariServices

import MarkedView

class UIMarkedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "sample", ofType: "md")!

        let mdView = UIMarkedView()
        mdView.delegate = self
        
        // code block in scrolling be deactivated.
        // mdView.setCodeScrollDisable()
        
        self.view = mdView
        mdView.loadFile(path)
    }
    
}

extension UIMarkedController: UIMarkViewDelegate {
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
