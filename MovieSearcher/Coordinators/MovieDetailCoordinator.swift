//
//  MovieDetailCoordinator.swift
//  MovieSearcher
//
//  Created by Daniel Romero on 2021-11-08.
//

import UIKit

class MovieDetailCoordinator: Coordinator {
    private(set) var movieDetailVC: MovieDetailVC
    
    init(movie: Movie) {
        let movieDetailVC = MovieDetailVC(viewModel: MovieDetailVM(movie: movie))
        movieDetailVC.modalPresentationStyle = .fullScreen
        self.movieDetailVC = movieDetailVC
    }
    
    func start(presentationHandler: @escaping (UIViewController) -> ()) {
        presentationHandler(self.movieDetailVC)
    }
}
