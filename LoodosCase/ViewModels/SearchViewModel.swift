//
//  SearchViewModel.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 22.08.2021.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject{
    func getSearchResults()
}

class SearchViewModel {
    
    var results = [SearchResult]()
    weak var delegate: SearchViewModelDelegate?
    func searchRequest(with query: String) {
        Service.shared.searchMovies(with: query) { result in
            self.results = result.Search
            self.delegate?.getSearchResults()
        }
    }
}
