//
//  Coordinator.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-08.
//

import UIKit

protocol Coordinator: AnyObject {
    func start(presentationHandler: @escaping (UIViewController) -> ())
}
