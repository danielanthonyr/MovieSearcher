//
//  MovieListCoordinator.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-08.
//

import UIKit

class MovieListCoordinator: Coordinator {
    private var movieDetailCoordinator: MovieDetailCoordinator?
    private var movieListVC: UINavigationController
    
    init() {
        let movieListVC = MovieListVC(viewModel: MovieListVM())
        let movieListNC = UINavigationController(rootViewController: movieListVC)
        self.movieListVC = movieListNC
        movieListVC.delegate = self
    }
    
    func start(presentationHandler: @escaping (UIViewController) -> ()) {
        presentationHandler(self.movieListVC)
    }
}

extension MovieListCoordinator: MovieListVCDelegate {
    func movieListVC(_ controller: MovieListVC, didSelect movie: Movie) {
        let movieDetailCoordinator = MovieDetailCoordinator(movie: movie)
        self.movieDetailCoordinator = movieDetailCoordinator
        movieListVC.pushViewController(movieDetailCoordinator.movieDetailVC, animated: true)
    }
}
