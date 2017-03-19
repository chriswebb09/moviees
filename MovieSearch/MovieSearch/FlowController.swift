//
//  FlowController.swift
//  MovieSearch
//
//  Created by Christopher Webb-Orenstein on 3/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

enum FlowType {
    case main
    case navigation
}

struct FlowConfigure {
    
    let window : UIWindow?
    let navigationController : UINavigationController?
    let parent : FlowController?
    
    func getFlowType() -> FlowType? {
        if window != nil { return .main }
        if navigationController != nil { return .navigation }
        return nil
    }
}

protocol FlowController {
    init(configure : FlowConfigure)
    func start()
}
