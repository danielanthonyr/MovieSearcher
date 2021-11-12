//
//  MovieCollectionViewCell.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import Foundation
import UIKit

protocol MovieCollectionViewCellDelegate: AnyObject {
    func movieCellDidTap(_ movie: Movie)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    static let reuseIdentifier = "MovieCell"
    
    private(set) var containerCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 6.0
        view.layer.shadowOpacity = 0.7
        return view
    }()
    
    private(set) var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) var movieFavoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 24,
                                                                               weight: .bold)),
                        for: UIControl.State.normal)
        button.tintColor = .yellow
        return button
    }()
    
    private(set) var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Wonder Woman"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private(set) var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Diana is amazonian wonder woman, very strong wow."
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
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
        contentView.addSubview(containerCardView)
        movieImageView.addSubview(movieFavoritesButton)
        containerCardView.addSubview(movieImageView)
        containerCardView.addSubview(movieTitleLabel)
        containerCardView.addSubview(movieDescriptionLabel)
    }
    
    private func setupConstraints() {
        containerCardView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        )
        
        movieImageView.anchor(
            top: containerCardView.topAnchor,
            leading: containerCardView.leadingAnchor,
            bottom: nil,
            trailing: containerCardView.trailingAnchor,
            size: CGSize(width: 0, height: 100)
        )
        
        movieFavoritesButton.anchor(
            top: movieImageView.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: movieImageView.trailingAnchor,
            padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 8)
        )
        
        movieTitleLabel.anchor(
            top: movieImageView.bottomAnchor,
            leading: containerCardView.leadingAnchor,
            bottom: nil,
            trailing: containerCardView.trailingAnchor,
            padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8),
            size: CGSize(width: 0, height: 50)
        )
        
        movieDescriptionLabel.anchor(
            top: movieTitleLabel.bottomAnchor,
            leading: containerCardView.leadingAnchor,
            bottom: nil,
            trailing: containerCardView.trailingAnchor,
            padding: UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)
        )
        
        NSLayoutConstraint.activate([
            //movieImageView.centerXAnchor.constraint(equalTo: containerCardView.centerXAnchor)
        ])
    }
    
    func configureImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.movieImageView.image = image
            }
        }
        task.resume()
    }
    
    func configure(movie: Movie) {
        movieTitleLabel.text = movie.trackName
        if let description = movie.shortDescription {
            movieDescriptionLabel.text = description
        } else {
            movieDescriptionLabel.text = movie.longDescription
        }
        
        if UserDefaults.standard.favorites.contains(String(movie.trackId)) {
            movieFavoritesButton.setImage(UIImage(systemName: "star.fill",
                                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24,
                                                                                                 weight: .bold)),
                                          for: UIControl.State.normal)
        } else {
            movieFavoritesButton.setImage(UIImage(systemName: "star",
                                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24,
                                                                                                 weight: .bold)),
                                          for: UIControl.State.normal)
        }
    }
}
