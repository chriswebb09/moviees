//
//  MainFlowController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//


import UIKit


class MainFlowController : FlowController {
    
    let configure : FlowConfigure
    var childFlow : FlowController?
    
    required init(configure : FlowConfigure) {
        self.configure = configure
    }
    
    func start() {
        
        let navigationController = UINavigationController()
        if let frame = configure.window?.bounds {
            navigationController.view.frame = frame
        }
        
        configure.window?.rootViewController = navigationController
        configure.window?.makeKeyAndVisible()
        
        let mainConfiguration = FlowConfigure(window: nil, navigationController: navigationController, parent: self)
        
        
        
     //   let owlConf = FlowConfigure(window: nil, navigationController: navigationController, parent: self)
       // childFlow = OwlsFlowController(configure: owlConf)
       // childFlow?.start()
    }
}
