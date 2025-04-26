//
//  Movie.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let imdbId: String
    let year: String

    enum CodingKeys: String, CodingKey {
        case title
        case imdbId = "imdb_id"
        case year
    }
}
