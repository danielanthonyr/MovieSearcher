//
//  MovieDetailVC.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import UIKit
import AVKit
import AVFoundation
import Combine

class MovieDetailVC: UIViewController {
    
    // MARK: - Variables
    
    private var viewModel: MovieDetailVM
    private var cancellables = Set<AnyCancellable>()
    
    private var moviePlayerController = AVPlayerViewController()
    private var playerView = AVPlayer()
    
    // MARK: View
    
    private var views = MovieDetailView()
    
    // MARK: Initializers
    
    init(viewModel: MovieDetailVM) {
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
        
        setupEventHandlers()
        getThumbnailFromImage(url: URL(string: viewModel.movie.previewUrl)!) { [weak self] (thumbImage) in
            self?.views.movieThumbnailView.image = thumbImage
            self?.views.movieThumbnailButton.isHidden = false
        }
        setupUI()
    }
    
    // MARK: Methods
    
    func setupUI() {
        views.configure(movie: viewModel.movie)
        views.movieReleaseDateLabel.text = viewModel.getYear()
        updateFavoritesButtonUI(isFavorite: viewModel.movie.isFavorite)
    }
    
    func updateFavoritesButtonUI(isFavorite: Bool) {
        if isFavorite {
            views.favoritesButton.configuration?.image = UIImage(systemName: "star.fill")
            views.favoritesButton.configuration?.title = "Added to favorites!"
        } else {
            views.favoritesButton.configuration?.image = UIImage(systemName: "star")
            views.favoritesButton.configuration?.title = "Add to favorites"
        }
    }
    
    func setupEventHandlers() {
        views.movieThumbnailButton.addTarget(self, action: #selector(self.playButtonPressed), for: .touchUpInside)
        views.favoritesButton.addTarget(self, action: #selector(self.favoritesButtonPressed), for: .touchUpInside)
    }
    
    func getThumbnailFromImage(url: URL, completion: @escaping ((_ image: UIImage) -> Void)) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbnailTime = CMTimeMake(value: 7, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func playButtonPressed() {
        playVideo()
    }
    
    @objc func favoritesButtonPressed() {
        if !viewModel.movie.isFavorite {
            viewModel.addMovieToFavorites()
            updateFavoritesButtonUI(isFavorite: viewModel.movie.isFavorite)
        } else {
            viewModel.removeMovieFromFavorites()
            updateFavoritesButtonUI(isFavorite: viewModel.movie.isFavorite)
        }
    }
    
    func playVideo() {
        let url: URL = URL(string: viewModel.movie.previewUrl)!
        playerView = AVPlayer(url: url as URL)
        moviePlayerController.player = playerView
        
        // Present player view controller
        self.present(moviePlayerController, animated: true) {
            self.moviePlayerController.player?.play()
        }
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
