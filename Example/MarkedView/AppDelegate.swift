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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.createMenuView()
        
        return true
    }
    
    private func createMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("FirstView") as! MainViewController
        
        let nvc = UINavigationController(rootViewController: mainViewController)
        
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }

}

