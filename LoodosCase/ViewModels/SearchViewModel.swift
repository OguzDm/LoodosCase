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
    func searchRequest(with query: String,page: Int) {
        Service.shared.searchMovies(with: query,page: page) { result in
            self.results.append(contentsOf: result.Search)
            self.delegate?.getSearchResults()
        }
    }
}
