//
//  Router.swift
//  test_kino
//
//  Created by Рауан Аблайхан on 26.04.2025.
//

import UIKit

class Router {

    static func navigateToMovieList(from window: UIWindow) {
        let movieListVC = MovieListViewController()
        let navigationController = UINavigationController(rootViewController: movieListVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    static func navigateToMovieDetails(from viewController: UIViewController, with movieId: String) {
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.movieId = movieId
        viewController.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
