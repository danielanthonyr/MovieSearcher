//
//  Movie.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//
import Foundation

struct Movie: Decodable {
    let trackId: Int
    let trackName: String // Itunes API documentation deprecated, movie name is trackName
    let artistName: String // Itunes API documentation deprecated, director name is artistName
    let releaseDate: String
    let shortDescription: String?
    let longDescription: String
    let previewUrl: String
    let artworkUrl100: String
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case trackId,
             trackName,
             artistName,
             releaseDate,
             shortDescription,
             longDescription,
             previewUrl,
             artworkUrl100
    }
}
