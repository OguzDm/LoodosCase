//
//  MovieDetailViewModel.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 22.08.2021.
//

import Foundation

protocol MovieDetailViewModelDelegate:AnyObject {
    func loadDetails(with model: MovieDetailModel)
}

final class MovieDetailViewModel {
    
    weak var delegate: MovieDetailViewModelDelegate?
    func fetchDetails(with id: String) {
        Service.shared.fetchDetails(with: id) { model in
            self.delegate?.loadDetails(with: model)
        }
    }
}
