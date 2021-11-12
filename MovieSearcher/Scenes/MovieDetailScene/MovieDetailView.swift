//
//  MovieDetailView.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import UIKit

class MovieDetailView: UIView {
    
    // MARK: - Variables
    
    private(set) var movieThumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private(set) var movieThumbnailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "play-button"), for: UIControl.State.normal)
        button.isHidden = true
        return button
    }()
    
    private(set) var movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private(set) var movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private(set) var movieDirectorLabel: UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private(set) var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Diana is amazonian wonder woman, very strong wow."
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) var favoritesButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupViews() {
        backgroundColor = .white
        configureButton()
        
        addSubview(movieThumbnailView)
        addSubview(movieInfoStackView)
        
        movieThumbnailView.addSubview(movieThumbnailButton)
        
        movieInfoStackView.addArrangedSubview(movieTitleLabel)
        movieInfoStackView.addArrangedSubview(movieReleaseDateLabel)
        movieInfoStackView.addArrangedSubview(movieDirectorLabel)
        movieInfoStackView.addArrangedSubview(movieDescriptionLabel)
        movieInfoStackView.addArrangedSubview(favoritesButton)
        movieInfoStackView.setCustomSpacing(32, after: (movieDescriptionLabel))
    }
    
    private func setupConstraints() {
        movieThumbnailView.anchor(
            top: safeTopAnchor,
            leading: safeLeadingAnchor,
            bottom: nil,
            trailing: safeTrailingAnchor
        )
        
        movieThumbnailButton.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: 100, height: 100)
        )
        
        movieInfoStackView.anchor(
            top: movieThumbnailView.bottomAnchor,
            leading: safeLeadingAnchor,
            bottom: nil,
            trailing: safeTrailingAnchor,
            padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        )
        
        NSLayoutConstraint.activate([
            movieThumbnailView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            movieThumbnailButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieThumbnailButton.centerYAnchor.constraint(equalTo: movieThumbnailView.centerYAnchor),
        ])
    }
    
    func configure(movie: Movie) {
        movieTitleLabel.text = movie.trackName
        movieReleaseDateLabel.text = movie.releaseDate
        movieDirectorLabel.text = movie.artistName
        
        if let description = movie.shortDescription {
            movieDescriptionLabel.text = description
        } else {
            movieDescriptionLabel.text = movie.longDescription
        }
    }
    
    func configureButton() {
        favoritesButton.configuration = .tinted()
        favoritesButton.configuration?.title = "Add to favorites"
        favoritesButton.configuration?.baseForegroundColor = .darkGray
        favoritesButton.configuration?.baseBackgroundColor = .darkGray
        favoritesButton.configuration?.image = UIImage(systemName: "star")
        favoritesButton.configuration?.imagePadding = 6
    }
}
