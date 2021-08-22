//
//  MovieDetailView.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 22.08.2021.
//

import UIKit
import Kingfisher
import Firebase

final class MovieDetailView: UIViewController, MovieDetailViewModelDelegate {
    
    func loadDetails(with model: MovieDetailModel) {
        
        Analytics.logEvent("movie_detail", parameters:
                            model.dictionary)
        guard let imageURL = URL(string: model.Poster) else {return}
        self.movieImageView.kf.indicatorType = .activity
        self.movieImageView.kf.setImage(with: imageURL)
        self.runTimeLabel.text = model.runtime
        self.genreLabel.text = model.Genre
        self.languageLabel.text = model.language
        self.movieNameLabel.text = model.Title
        self.plotLabel.text = model.Plot
        self.imdbRating.text = model.imdbRating
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    
    let movieDetailViewModel = MovieDetailViewModel()
    var imdbID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailViewModel.delegate = self
        movieDetailViewModel.fetchDetails(with: imdbID)
    }
}
