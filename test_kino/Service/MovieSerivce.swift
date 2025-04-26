//
//  MovieSerivce.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation

class MovieService {
    func fetchMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        MovieAPI.fetchMovies(page: page) { result in
            switch result {
            case .success(let response):
                completion(.success(response.movieResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
