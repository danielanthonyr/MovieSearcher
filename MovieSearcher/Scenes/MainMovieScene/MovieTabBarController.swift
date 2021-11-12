//
//  MovieTabBarController.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-05.
//

import Foundation
import UIKit

class MovieTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}
