//
//  MovieDetailVM.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import Foundation
import Combine

class MovieDetailVM {
    @Published var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        
        if UserDefaults.standard.favorites.contains(String(movie.trackId)) {
            self.movie.isFavorite = true
        }
    }
    
    // get year from string date
    func getYear() -> String {
        return String(movie.releaseDate.prefix(4))
    }
    
    func addMovieToFavorites() {
        movie.isFavorite = true
        UserDefaults.standard.favorites.append(String(movie.trackId))
    }
    
    func removeMovieFromFavorites() {
        movie.isFavorite = false
        UserDefaults.standard.favorites.removeAll {
            $0 == String(movie.trackId)
        }
    }
}
