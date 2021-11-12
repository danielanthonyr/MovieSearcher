//
//  MovieFavoritesVC.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

import UIKit
import Combine

protocol MovieFavoritesVCDelegate: AnyObject {
    func movieFavoritesVC(_ controller: MovieFavoritesVC, didSelect movie: Movie)
}

class MovieFavoritesVC: UIViewController {
    
    // MARK: - Variables
    
    weak var delegate: MovieFavoritesVCDelegate?
    private var viewModel: MovieFavoritesVM
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: View
    
    private var views = MovieFavoritesView()
    
    // MARK: Initializers
    
    init(viewModel: MovieFavoritesVM) {
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
        
        showLoadingActivity()
        setupNavbar()
        setupCollectionView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        if viewModel.favorites.count > 0 {
            viewModel.favorites.removeAll()
        }
        viewModel.fetchFavorites()
    }

    // MARK: Methods
    
    func setupNavbar() {
        title = "Favorites"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: "Futura-Bold", size: 24)!,
         NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func setupCollectionView() {
        views.movieCollectionView.dataSource = self
        views.movieCollectionView.delegate = self
    }
    
    func setupBindings() {
        self.viewModel.$favorites.sink { [weak self] result in
            print(result)
            DispatchQueue.main.async {
                self?.dismissLoadingActivity()
                self?.views.movieCollectionView.reloadData()
            }
        }
        .store(in: &cancellables)
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
    
    func dismissLoadingActivity() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - Collection View Delegate

extension MovieFavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = viewModel.favorites[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureImage(with: movie.artworkUrl100)
        cell.configure(movie: movie)
        
        cell.movieFavoritesButton.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.favorites[indexPath.row]
        
        delegate?.movieFavoritesVC(self, didSelect: movie)
    }
}
