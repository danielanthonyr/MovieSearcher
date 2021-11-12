//
//  ApplicationCoordinator.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-08.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private var rootVC: MainViewController
    private var mainViewCoordinator: MainViewCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        
        rootVC = MainViewController()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
    
    func start(presentationHandler: @escaping (UIViewController) -> ()) {
        mainViewCoordinator = MainViewCoordinator(mainViewController: rootVC)
        
        mainViewCoordinator?.start { (controller) in
            
        }
    }
}
