//
//  MovieDetailViewModel.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service = MovieDetailService()

    func loadMovieDetail(movieId: String) {
        isLoading = true
        errorMessage = nil
        
        service.fetchMovieDetail(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let detail):
                    self?.movieDetail = detail
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
