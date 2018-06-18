//
//  AppDelegate.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 11/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var initialNavigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.red
        let viewModel = NodeInfoViewModel()
        let viewController = ListOfNodesViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        initialNavigationController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

