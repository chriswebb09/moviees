//
//  AppDelegate.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 2/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        //var main = MainFlowController(configure: FlowConfigure(window: window, navigationController: UINavigationController(), parent: nil))
        //print(main.start())
        
        //print(main.configure.getFlowType())
        // main.start()
        // print(main.configure.getFlowType())
        return window
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let configure = FlowConfigure(window: window, navigationController: UINavigationController(), parent: nil)
        let mainFlow = MainFlowController(configure: configure)
        mainFlow.start()
        
        return true
    }
    
//     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        window = UIWindow(frame : UIScreen.main.bounds)
//        let configure = FlowConfigure(window: window, navigationController: UINavigationController(), parent: nil)
//        let mainFlow = MainFlowController(configure: configure)
//        mainFlow.start()
//        
//        return true
//    }
//    
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
//        window?.rootViewController = initialViewController
//        let configure = FlowConfigure(window: window, navigationController: nil, parent: nil)
//        let mainFlow = MainFlowController(configure: configure)
//        mainFlow.start()
//        
//       // self.window?.makeKeyAndVisible()
//        return true
//    }
}

