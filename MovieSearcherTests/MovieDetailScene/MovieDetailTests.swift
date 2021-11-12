//
//  MovieDetailTests.swift
//  MovieSearcherTests
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

@testable import MovieSearcher
import XCTest

class MovieDetailTests: XCTestCase {
    
    var viewModel: MovieDetailVM!
    
    override func setUp() {
        let movie = Movie(
            trackId: 123,
            trackName: "Wonder Woman",
            artistName: "Patty Jenkins",
            releaseDate: "2017-07-08",
            shortDescription: "Wonder woman very strong wow",
            longDescription: "Wonder woman very strong wow and she must save world",
            previewUrl: "https://video-ssl.itunes.apple.com/itunes-assets/Video127/v4/aa/e0/f6/aae0f641-c5e1-bead-5094-9f842c7ff620/mzvf_8847721542367954600.640x352.h264lc.U.p.m4v",
            artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Video124/v4/bb/a8/19/bba8195b-56ec-1d2d-d73f-8a533322dd2b/pr_source.lsr/100x100bb.jpg"
        )
        
        viewModel = MovieDetailVM(movie: movie)
    }

    func testGetYear() {
        XCTAssertTrue(viewModel.getYear() == "2017")
    }
    
    func testAddMovieToFavorites() {
        viewModel.addMovieToFavorites()
        XCTAssertTrue(UserDefaults.standard.favorites.contains("\(viewModel.movie.trackId)"))
    }
    
    func testRemoveMovieFromFavorites() {
        viewModel.addMovieToFavorites()
        viewModel.removeMovieFromFavorites()
        XCTAssertFalse(UserDefaults.standard.favorites.contains("\(viewModel.movie.trackId)"))
    }
}
