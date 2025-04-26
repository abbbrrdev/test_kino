import UIKit
import Combine
import SnapKit

class MovieDetailViewController: UIViewController {

    // MARK: - Properties
    private var viewModel = MovieDetailViewModel()

    private var cancellables = Set<AnyCancellable>()
    
    var movieId: String?
    
    // MARK: - UI Elements
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        if let movieId = movieId {
            loadMovieDetail(movieId: movieId)
        }
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        [titleLabel, descriptionLabel, yearLabel, ratingLabel, genreLabel, activityIndicator, errorLabel].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalTo(view).inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalTo(view).inset(16)
        }

        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(view).inset(16)
        }

        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(8)
            make.left.equalTo(view).inset(16)
        }

        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(8)
            make.left.equalTo(view).inset(16)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(16)
            make.left.right.equalTo(view).inset(16)
        }
    }
    
    private func setupBindings() {
        viewModel.$movieDetail
            .sink { [weak self] detail in
                guard let self = self, let detail = detail else { return }
                self.titleLabel.text = detail.title
                self.descriptionLabel.text = detail.description
                self.yearLabel.text = "Year: \(detail.year)"
                self.ratingLabel.text = "Rating: \(detail.imdb_rating)"
                self.genreLabel.text = "Genres: \(detail.genres?.joined(separator: ", ") ?? "N/A")"
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .sink { [weak self] isLoading in
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
            }
            .store(in: &cancellables)
    }
    
    private func loadMovieDetail(movieId: String) {
        viewModel.loadMovieDetail(movieId: movieId)
    }
}
