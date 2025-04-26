//
//  MovieListViewModel.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import Foundation

class MovieListViewModel {
    private let service = MovieService()
    
    private var allMovies: [Movie] = []
    private(set) var movies: [Movie] = []

    private var currentPage = 3
    private var isFetching = false
    private var hasMorePages = true

    var onMoviesUpdated: (() -> Void)?

    func fetchMovies() {
        guard !isFetching && hasMorePages else { return }
        isFetching = true

        service.fetchMovies(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isFetching = false

                switch result {
                case .success(let newMovies):
                    if newMovies.isEmpty {
                        self.hasMorePages = false
                    } else {
                        self.allMovies.append(contentsOf: newMovies)
                        self.movies.append(contentsOf: newMovies)
                        self.currentPage += 1
                        self.onMoviesUpdated?()
                    }
                case .failure(let error):
                    print("Ошибка загрузки фильмов: \(error)")
                }
            }
        }
    }

    func numberOfMovies() -> Int {
        return movies.count
    }

    func movie(at index: Int) -> Movie {
        return movies[index]
    }

    func filterMovies(by year: Int) {
        movies = allMovies.filter { Int($0.year) == year }
        onMoviesUpdated?()
    }

    func resetFilter() {
        movies = allMovies
        onMoviesUpdated?()
    }
}
