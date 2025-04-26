//
//  Untitled.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

enum API {
    static let getMoviesURL = "https://movies-tv-shows-database.p.rapidapi.com"
    
    static func movieDetailIdURL(for movieId: String) -> String {
           return "\(getMoviesURL)/?movieid=\(movieId)"
    }
}
