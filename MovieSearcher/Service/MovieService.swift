//
//  Networking.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import Foundation

enum MovieError: Error {
    case NoDataAvailable
    case invalidURL
    case keyNotFound
    case valueNotFound
    case typeMismatch
    case dateCorrupted
    case defaultError
}

// using protocol pattern for dependency injection in our tests
protocol MovieServiceProtocol {
    func getMovies(query: String, completion: @escaping(Result<[Movie], MovieError>) -> Void)
    func getFavorites(movieId: String, completion: @escaping(Result<[Movie], MovieError>) -> Void)
}

struct MovieService: MovieServiceProtocol {
    let session = URLSession.shared
    
    func getMovies(query: String, completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        let queryNoWhiteSpace = query.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let movieURL = "https://itunes.apple.com/search?media=movie&country=US&term=\(queryNoWhiteSpace)&entity=movie"
        
        guard let movieURL = URL(string: movieURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = session.dataTask(with: movieURL) { data, _ , _ in
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieApiResponse.self, from: jsonData)
                let results = movieResponse.results
                completion(.success(results))
            } catch DecodingError.keyNotFound {
                completion(.failure(.keyNotFound))
            } catch DecodingError.valueNotFound {
                completion(.failure(.valueNotFound))
            } catch DecodingError.typeMismatch {
                completion(.failure(.typeMismatch))
            } catch DecodingError.dataCorrupted {
                completion(.failure(.dateCorrupted))
            } catch _ as NSError {
                completion(.failure(.defaultError))
            }
        }
        dataTask.resume()
    }
    
    func getFavorites(movieId: String, completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        let movieURL = "https://itunes.apple.com/lookup?id=\(movieId)"
        
        guard let movieURL = URL(string: movieURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = session.dataTask(with: movieURL) { data, _ , _ in
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieApiResponse.self, from: jsonData)
                let results = movieResponse.results
                completion(.success(results))
            } catch DecodingError.keyNotFound {
                completion(.failure(.keyNotFound))
            } catch DecodingError.valueNotFound {
                completion(.failure(.valueNotFound))
            } catch DecodingError.typeMismatch {
                completion(.failure(.typeMismatch))
            } catch DecodingError.dataCorrupted {
                completion(.failure(.dateCorrupted))
            } catch _ as NSError {
                completion(.failure(.defaultError))
            }
        }
        dataTask.resume()
    }
}
