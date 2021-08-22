//
//  ViewController.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 21.08.2021.
//

import UIKit

final class MainView: UIViewController, SearchViewModelDelegate {
    func getSearchResults() {
       reloadTableView()
    }
    
    private var currentPage = 1
    private var currentQuery = ""
    private let searchViewModel = SearchViewModel()
    private let searchController = UISearchController()
    private var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        configureTableView()
        prepareNavigationBar()
    }
    
    private func configureTableView(){
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.loadNib(name: SearchTableViewCell.reuseIdentifier), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    private func prepareNavigationBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MovieDetailView") as? MovieDetailView else {return}
        detailVC.imdbID = searchViewModel.results[indexPath.row].imdbId
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == searchViewModel.results.count - 2 {
            currentPage += 1
            searchViewModel.searchRequest(with: currentQuery, page: currentPage)
        }
    }
}

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configure(image: searchViewModel.results[indexPath.row].poster, name: searchViewModel.results[indexPath.row].title, type: searchViewModel.results[indexPath.row].type)
        
        return cell
    }
}

extension MainView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            currentQuery = searchText
            currentPage = 1
            searchViewModel.results.removeAll()
            reloadTableView()
            searchViewModel.searchRequest(with: searchText,page: currentPage)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentQuery = ""
        currentPage = 1
        searchViewModel.results.removeAll()
        reloadTableView()
    }
}

