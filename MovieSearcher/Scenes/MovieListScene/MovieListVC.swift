//
//  MovieSearchVC.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import UIKit
import Combine

protocol MovieListVCDelegate: AnyObject {
    func movieListVC(_ controller: MovieListVC, didSelect movie: Movie)
}

class MovieListVC: UIViewController {
    
    // MARK: - Variables
    
    weak var delegate: MovieListVCDelegate?
    private var viewModel: MovieListVM
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: View
    
    private var views = MovieListView()
    
    // MARK: Initializers
    
    init(viewModel: MovieListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupCollectionView()
        setupSearchbar()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.views.movieCollectionView.reloadData()
        }
    }
    
    // MARK: Methods
    
    func setupNavbar() {
        title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: "Futura-Bold", size: 24)!,
         NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func setupCollectionView() {
        views.movieCollectionView.dataSource = self
        views.movieCollectionView.delegate = self
    }
    
    func setupSearchbar() {
        views.searchBar.delegate = self
    }
    
    func showLoadingActivity() {
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func setupBindings() {
        self.viewModel.$movies.sink { [weak self] result in
            DispatchQueue.main.async {
                self?.views.movieCollectionView.reloadData()
                if let vc = self?.presentedViewController, vc is UIAlertController {
                    self?.dismiss(animated: false, completion: nil)
                }
            }
        }
        .store(in: &cancellables)
        
        self.viewModel.$error.sink { [weak self] result in
            DispatchQueue.main.async {
                if let vc = self?.presentedViewController, vc is UIAlertController {
                    self?.dismiss(animated: false) {
                        if let result = result {
                            let alert = UIAlertController(title: "Network Error", message: "\(result)", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        .store(in: &cancellables)
    }
}

// MARK: - Collection View Delegate

extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = viewModel.movies[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureImage(with: movie.artworkUrl100)
        cell.configure(movie: movie)
        
        cell.movieFavoritesButton.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        delegate?.movieListVC(self, didSelect: movie)
    }
}

// MARK: - Search Bar Delegate

extension MovieListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.views.movieImageView.isHidden = true
        self.views.searchLabel.isHidden = true
        
        if let text = searchBar.text {
            viewModel.movies = []
            views.movieCollectionView.reloadData()
            // show loading
            showLoadingActivity()
            viewModel.fetchMovies(query: text)
        }
    }
}
