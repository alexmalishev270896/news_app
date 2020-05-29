//
//  SearchViewController.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var placeholderText: UILabel!
    var viewModel: ISearchViewModel?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let configurator: BaseConfigurator = SearchNewsConfigurator()
    private var newsDisposable: Disposable?
    private var newsItems: [NewsProjection.NewsItem] = [] {
        didSet{
            searchTableView.reloadData()
            placeholderText.isHidden = !newsItems.isEmpty
        }
    }
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetails" {
            let detailsVC = segue.destination as! NewsDetailViewController
            detailsVC.newsItem = sender as? NewsProjection.NewsItem
        }
    }
    
    private func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView(){
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.delaysContentTouches = false
    }
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count >= 3 {
            newsDisposable?.dispose()
            newsDisposable = viewModel?.search(by: text)
                .subscribe(onSuccess: { news in
                    self.newsItems = news
                })
        }else {
            self.newsItems = []
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsItem = newsItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        cell.newsItem = newsItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row \(indexPath.row)")
        let newsItem = newsItems[indexPath.row]
        performSegue(withIdentifier: "SearchToDetails", sender: newsItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
