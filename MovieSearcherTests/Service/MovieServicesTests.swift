//
//  MovieServiceTests.swift
//  MovieSearcherTests
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

@testable import MovieSearcher
import XCTest

class MovieServicesTests: XCTestCase {
    var movieListVM: MovieListVM!
    var movieFavoritesVM: MovieFavoritesVM!
    var mockMovieService: MockMovieService!
    var movieService: MovieService!
    
    // we want to INJECT a mock movie service into our VM and see how it behaves
    override func setUp() {
        mockMovieService = MockMovieService()
        movieService = MovieService()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test with dependency injection example
    func testFetchMovieSetsSuccessWithMovie() {
        var movies: [Movie] = []
        // injecting mock movie service into viewmodel
        movieListVM = .init(movieService: mockMovieService)
        movieListVM.fetchMovies(query: "")
        movies = movieListVM.movies
        XCTAssertTrue(movies.count > 0)
    }
    
    func testFetchMovies() {
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Fetching movies with query")

        movieService.getMovies(query: "beast", completion: { result in
            switch result {
            case .failure(let error):
                XCTAssertFalse(true, error.localizedDescription)
            case .success(let movies):
                // Make sure we downloaded some data.
                XCTAssertNotNil(movies, "Movies successfully fetched.")
                expectation.fulfill()
            }
        })

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchFavorites() {
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Fetching Favoritespage")

        // Create a background task to download the web page.

        movieService.getFavorites(movieId: "1235765633", completion: { result in
            switch result {
            case .failure(let error):
                XCTAssertFalse(true, error.localizedDescription)
            case .success(let movies):
                // Make sure we downloaded some data.
                XCTAssertNotNil(movies, "Movies successfully fetched.")
                expectation.fulfill()
            }
        })

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 5.0)
    }
}
