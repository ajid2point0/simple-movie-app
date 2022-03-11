//
//  MoviesListVC.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import UIKit

final class MoviesListVC: UITableViewController {
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    let model: MoviesListModel
    
    init(model: MoviesListModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        model.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = UIColor.black
        view.addSubview(activityIndicator)
        
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    override func viewDidLayoutSubviews() {
        activityIndicator.center = self.tableView.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        model.fetchMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.cancel()
    }
    
}

extension MoviesListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {fatalError()}
        cell.configure(movie: model.movies[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == model.movies.count - 1, model.shouldLoadMore {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = UIColor.black
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            model.fetchMovies()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = model.movies[indexPath.row]
        let movieVC = MovieVC(movie: movie)
        self.present(movieVC, animated: true)
    }
    
}

extension MoviesListVC: MoviesListDelegate {
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.tableFooterView = nil
            self.tableView.reloadData()
        }
    }
    
    func onError(message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(action)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.tableFooterView = nil
            self.present(alertVC, animated: true)
        }
    }
    
}
