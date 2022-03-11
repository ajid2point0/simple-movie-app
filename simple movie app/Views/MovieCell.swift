//
//  MovieCell.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return MovieCell.description()
    }
    
    private lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .black)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        
        contentView.backgroundColor = UIColor.white
        selectionStyle = .none
        
        contentView.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            moviePoster.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moviePoster.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            moviePoster.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: moviePoster.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        contentView.addSubview(yearLabel)
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
    public func configure(movie: Movie) {
        if let imagePath = movie.posterPath {
            let imageUrl = Constants.imageBaseURL.rawValue + imagePath
            
            if let url = URL(string: imageUrl) {
                moviePoster.sd_setImage(
                    with: url,
                    placeholderImage: nil,
                    options: .progressiveLoad
                )
            }
            
        }
        titleLabel.text = movie.title
        yearLabel.text = movie.releasDate
    }
}
