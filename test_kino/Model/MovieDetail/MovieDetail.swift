//
//  MovieDetail.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation

struct MovieDetail: Decodable {
    let title: String?
    let description: String?
    let tagline: String?
    let year: String?
    let release_date: String?
    let imdb_id: String?
    let imdb_rating: String?
    let vote_count: String?
    let popularity: String?
    let youtube_trailer_key: String?
    let rated: String?
    let runtime: Int?
    let genres: [String]?
    let stars: [String]?
    let directors: [String]?
    let countries: [String]?
    let language: [String]?
    let status: String?
    let status_message: String?
}
