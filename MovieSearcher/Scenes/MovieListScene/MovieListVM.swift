//
//  MovieSearchVM.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import Combine

class MovieListVM {
    @Published var movies: [Movie] = []
    @Published var error: MovieError?
    
    private let movieService: MovieServiceProtocol
    
    // injecting movie service into movieSearchVM
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func fetchMovies(query: String) {
        movieService.getMovies(query: query) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
            case .success(let movies):
                self?.movies = movies
            }
        }
    }
}
