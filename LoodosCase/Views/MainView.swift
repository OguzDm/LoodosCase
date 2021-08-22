//
//  ViewController.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 21.08.2021.
//

import UIKit

class MainView: UIViewController, SearchViewModelDelegate {
    func getSearchResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    let searchViewModel = SearchViewModel()
    let searchController = UISearchController()
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        configureTableView()
        prepareNavigationBar()
    }
    
    func configureTableView(){
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.loadNib(name: SearchTableViewCell.reuseIdentifier), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    func prepareNavigationBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
            searchViewModel.searchRequest(with: searchText)
        }
    }
}

