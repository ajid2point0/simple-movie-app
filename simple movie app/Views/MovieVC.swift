//
//  MovieVC.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 10/3/2022.
//

import UIKit
import SDWebImage

class MovieVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        configuration()
    }
    
    private func createSubviews() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(posterView)
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            posterView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            posterView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.6),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.7)
        ])
        
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9)
        ])
        
        scrollView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9)
        ])
        
        scrollView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40)
        ])
        
    }
    
    private func configuration() {
        
        view.backgroundColor = UIColor.white
        
        if let path = movie.posterPath {
            let posterUrl = Constants.imageBaseURL.rawValue + path
            if let url = URL(string: posterUrl) {
                posterView.sd_setImage(with: url)
            }
        }
        
        titleLabel.text = movie.title
        dateLabel.text = movie.releasDate
        descriptionLabel.text = movie.overview
        
    }
}
