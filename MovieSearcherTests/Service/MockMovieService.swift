//
//  MockMovieService.swift
//  MovieSearcherTests
//
//  Created by Daniel Romero on 2021-11-06.
//

import Foundation
@testable import MovieSearcher

final class MockMovieService: MovieServiceProtocol {
    
    var movieResult: Result<[Movie], MovieError> = .success([Movie(
        trackId: 4,
        trackName: "Beauty and the Beast",
        artistName: "Bobby Smith",
        releaseDate: "2017",
        shortDescription: "Big monster falls in love with princess",
        longDescription: "Big monster falls in love with princess and lives happily ever after",
        previewUrl: "www.randomurl.com",
        artworkUrl100: "www.randomArtworkUrl.com")])
    
    var favoritesResult: Result<[Movie], MovieError> = .success([Movie(
        trackId: 4,
        trackName: "Beauty and the Beast",
        artistName: "Bobby Smith",
        releaseDate: "2017",
        shortDescription: "Big monster falls in love with princess",
        longDescription: "Big monster falls in love with princess and lives happily ever after",
        previewUrl: "www.randomurl.com",
        artworkUrl100: "www.randomArtworkUrl.com")])
    
    // we want to test success
    func getMovies(query: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        completion(movieResult)
    }
    
    func getFavorites(movieId: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        completion(favoritesResult)
    }
}
