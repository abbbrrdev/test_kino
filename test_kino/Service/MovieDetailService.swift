//
//  MovieDetailService.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation
import Alamofire

class MovieDetailService {
    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        MovieAPI.fetchMovieDetail(movieId: movieId) { result in
            switch result {
            case .success(let movieDetail):
                completion(.success(movieDetail))
            case .failure(let error):
//                print("Error occurred while fetching movie detail: \(error.localizedDescription)")
//                
//                if let afError = error as? AFError {
//                    print("Alamofire error: \(afError.localizedDescription)")
//                    print("Underlying error: \(afError.underlyingError?.localizedDescription ?? "No underlying error")")
//                }
                completion(.failure(error))
            }
        }
    }
}

