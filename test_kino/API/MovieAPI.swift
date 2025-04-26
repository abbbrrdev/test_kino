//
//  APIClient.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation
import Alamofire

enum MovieAPI {
    static func fetchMovies(page: Int = 3, completion: @escaping (Result<MovieResponse, AFError>) -> Void) {
        
        let url = API.getMoviesURL
        
        let parameters: Parameters = [
            "page": page
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: APIHeaders.with(type: "get-trending-movies")
        )
        .validate()
        .responseDecodable(of: MovieResponse.self) { response in
            completion(response.result)
        }
    }
    
    static func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetail, AFError>) -> Void) {
        let url = API.movieDetailIdURL(for: movieId)

        AF.request(
            url,
            method: .get,
            headers: APIHeaders.with(type: "get-movie-details")
        )
        .validate()
        .responseDecodable(of: MovieDetail.self) { response in
            completion(response.result)
        }
    }
}

