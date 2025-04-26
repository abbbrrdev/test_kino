//
//  MovieResponse.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation

struct MovieResponse: Decodable {
    let movieResults: [Movie]
    let results: Int
    let totalResults: String
    let status: String
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case results
        case totalResults = "Total_results"
        case status = "status"
        case statusMessage = "status_message"
    }
}
