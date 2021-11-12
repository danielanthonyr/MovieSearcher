//
//  MovieFavoritesView.swift
//  MovieSearcher
//
//  Created by Daniel-Anthony Romero on 2021-10-27.
//

import UIKit

class MovieFavoritesView: UIView {
    
    // MARK: - Variables
    
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
        
        addSubview(movieCollectionView)
    }
    
    private func setupConstraints() {
        movieCollectionView.anchor(
            top: safeTopAnchor,
            leading: safeLeadingAnchor,
            bottom: safeBottomAnchor,
            trailing: safeTrailingAnchor
        )
    }
}
