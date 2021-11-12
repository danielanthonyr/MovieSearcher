//
//  MovieFavoritesVM.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

import Foundation
import Combine

class MovieFavoritesVM {
    @Published var favorites: [Movie] = []
    @Published var error: MovieError?
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let favorites = UserDefaults.standard.favorites
        
        for favorite in favorites {
            movieService.getFavorites(movieId: favorite) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.error = error
                case .success(let movies):
                    self?.favorites.append(contentsOf: movies)
                }
            }
        }
    }
}
