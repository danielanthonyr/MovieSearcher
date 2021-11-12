//
//  MovieSearchView.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-26.
//

import UIKit

class MovieListView: UIView {
    
    // MARK: - Variables
    
    private(set) var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private(set) var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2, height: 300)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    private(set) var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "movie-image")
        return imageView
    }()
    
    private(set) var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search Away..."
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
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
        backgroundColor = .white
        
        addSubview(searchBar)
        addSubview(movieCollectionView)
        addSubview(movieImageView)
        addSubview(searchLabel)
    }
    
    private func setupConstraints() {
        searchBar.anchor(
            top: safeTopAnchor,
            leading: safeLeadingAnchor,
            bottom: nil,
            trailing: safeTrailingAnchor,
            size: CGSize(width: 0, height: 50)
        )
        
        movieCollectionView.anchor(
            top: searchBar.bottomAnchor,
            leading: safeLeadingAnchor,
            bottom: safeBottomAnchor,
            trailing: safeTrailingAnchor
        )
        
        movieImageView.anchor(
            top: searchBar.bottomAnchor,
            leading: safeLeadingAnchor,
            bottom: nil,
            trailing: safeTrailingAnchor
        )
        
        searchLabel.anchor(
            top: movieImageView.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil
        )
        
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            searchLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
