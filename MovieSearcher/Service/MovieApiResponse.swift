//
//  ApiResponse.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import Foundation

struct MovieApiResponse: Decodable {
    let resultCount: Int
    let results: [Movie]
}
