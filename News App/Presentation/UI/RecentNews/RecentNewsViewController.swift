//
//  RecentNewsViewController.swift
//  News App
//
//  Created by Александр Малышев on 14.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit
import RxSwift

class RecentNewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    var viewModel: IRecentNewsViewModel? = nil
    
    private let configurator: BaseConfigurator = RecentNewsConfigurator()
    private var disposeBag: DisposeBag = DisposeBag()
    private var recentNews: Array<NewsProjection.NewsItem> = [] {
        didSet {
            newsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        navigationItem.title = "Recent News".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.delaysContentTouches = false
        viewModel?.recentNews
            .drive(onNext: { [unowned self] newsState in
                switch (newsState){
                case .error:
                    break
                case .loading:
                    break
                case .success(let items):
                    self.recentNews = items
                    break
                }
            })
            .disposed(by: disposeBag)
        viewModel?.getRecentNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail"{
            let destination = segue.destination as! NewsDetailViewController
            destination.newsItem = sender as? NewsProjection.NewsItem
        }
    }
}



extension RecentNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsItem = recentNews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! LargeNewsCell
        cell.selectionStyle = .none
        cell.newsItem = newsItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row \(indexPath.row)")
        let newsItem = recentNews[indexPath.row]
        performSegue(withIdentifier: "MasterToDetail", sender: newsItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselect row \(indexPath.row)")
    }
}
