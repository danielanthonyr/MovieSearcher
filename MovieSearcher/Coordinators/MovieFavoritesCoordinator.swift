//
//  MovieFavoritesCoordinator.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-08.
//

import UIKit

class MovieFavoritesCoordinator: Coordinator {
    private var movieDetailCoordinator: MovieDetailCoordinator?
    private var movieFavoritesVC: UINavigationController
    
    init() {
        let movieFavoritesVC = MovieFavoritesVC(viewModel: MovieFavoritesVM())
        let movieListNC = UINavigationController(rootViewController: movieFavoritesVC)
        self.movieFavoritesVC = movieListNC
        movieFavoritesVC.delegate = self
        
    }
    
    func start(presentationHandler: @escaping (UIViewController) -> ()) {
        presentationHandler(self.movieFavoritesVC)
    }
}

extension MovieFavoritesCoordinator: MovieFavoritesVCDelegate {
    func movieFavoritesVC(_ controller: MovieFavoritesVC, didSelect movie: Movie) {
        let movieDetailCoordinator = MovieDetailCoordinator(movie: movie)
        self.movieDetailCoordinator = movieDetailCoordinator
        movieFavoritesVC.pushViewController(movieDetailCoordinator.movieDetailVC, animated: true)
    }
}
