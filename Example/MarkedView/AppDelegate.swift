//
//  AppDelegate.swift
//  MarkedView
//
//  Created by mittsu on 04/10/2016.
//  Copyright (c) 2016 mittsu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.createMenuView()
        
        return true
    }
    
    fileprivate func createMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "FirstView") as! MainViewController
        
        let nvc = UINavigationController(rootViewController: mainViewController)
        
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }

}

