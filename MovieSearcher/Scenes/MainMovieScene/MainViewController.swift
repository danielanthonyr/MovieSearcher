//
//  MovieTabBarController.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

import Foundation
import UIKit

// Main view controller serves as the navigation layer.
class MainViewController: UIViewController {
    
    // MARK: - Variables
    
    let movieTabBarController = MovieTabBarController()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .pad ? UIInterfaceOrientationMask.all : UIInterfaceOrientationMask.portrait
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methods
    
}
