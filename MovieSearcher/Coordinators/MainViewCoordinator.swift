//
//  MainViewCoordinator.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-08.
//

import UIKit

class MainViewCoordinator: Coordinator {
    private var mainViewController: MainViewController
    private var movieListVC: MovieListVC?
    private var movieTabBarController: MovieTabBarController?
    
    private var movieListCoordinator: MovieListCoordinator?
    private var movieFavoritesCoordinator: MovieFavoritesCoordinator?
    
    init(mainViewController: MainViewController) {
        self.mainViewController = mainViewController
    }
    
    func start(presentationHandler: @escaping(UIViewController) -> ()) {
        let movieTabBarController = MovieTabBarController()
        var tabBarControllers: [UIViewController] = []
        
        movieListCoordinator = MovieListCoordinator()
        movieListCoordinator?.start { (controller) in
            controller.setTabBarImage(imageName: "magnifyingglass.circle", title: "Search")
            tabBarControllers.append(controller)
        }
        
        movieFavoritesCoordinator = MovieFavoritesCoordinator()
        movieFavoritesCoordinator?.start { (controller) in
            controller.setTabBarImage(imageName: "star", title: "Favorites")
            tabBarControllers.append(controller)
        }
        
        mainViewController.addChild(movieTabBarController)
        mainViewController.view.addSubview(movieTabBarController.view)
        movieTabBarController.didMove(toParent: mainViewController)
        
        movieTabBarController.viewControllers = tabBarControllers
        presentationHandler(mainViewController)
    }
}
