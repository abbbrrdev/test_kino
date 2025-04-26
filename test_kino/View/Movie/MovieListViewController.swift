//
//  MovieListViewController.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import UIKit

class MovieListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = MovieListViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchMovies()
    }

    private func setupUI() {
        title = "Фильмы"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        activityIndicator.hidesWhenStopped = true
        tableView.tableFooterView = activityIndicator
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(showBottomSheet)
        )
        settingsButton.tintColor = .black
        
        let clearFilterButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(clearFilter)
        )
        settingsButton.tintColor = .black
        clearFilterButton.tintColor = .red
        
        navigationItem.rightBarButtonItem = clearFilterButton
        navigationItem.leftBarButtonItem = settingsButton
    }

    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func showBottomSheet() {
        let bottomSheet = BottomSheetViewController()
        
        bottomSheet.years = viewModel.movies.compactMap { Int($0.year) }
        
        bottomSheet.onYearSelected = { [weak self] selectedYear in
            self?.viewModel.filterMovies(by: selectedYear)
        }
        
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(bottomSheet, animated: true)
    }
    
    @objc private func clearFilter() {
        viewModel.resetFilter()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MovieCell")
        let movie = viewModel.movie(at: indexPath.row)
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "Год: \(movie.year)"
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        Router.navigateToMovieDetails(from: self, with: movie.imdbId)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold = tableView.contentSize.height - tableView.frame.height - 100
        if scrollView.contentOffset.y > threshold {
            viewModel.fetchMovies()
        }
    }
}
