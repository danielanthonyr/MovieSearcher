//
//  UserDefaults+Append.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

import Foundation

extension UserDefaults {
    var favorites: [String] {
        get { stringArray(forKey: "favorites") ?? [] }
        set { set(newValue, forKey: "favorites") }
    }
}
