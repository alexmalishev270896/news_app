//
//  BookmarksViewController.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BookmarksViewController: UIViewController {
    
    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var viewModel: IBookmarksViewModel?
    
    private let configurator: BaseConfigurator<BookmarksViewController> = BookmarksConfigurator()
    private let disposeBag = DisposeBag()
    private var bookmarks: [NewsProjection.NewsItem] = []{
        didSet{
            bookmarksTableView.reloadData()
            placeholderLabel.isHidden = !bookmarks.isEmpty
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        bookmarksTableView.dataSource = self
        bookmarksTableView.delegate = self
        title = "Bookmarks"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel?.bookmarks
            .drive(onNext: { [unowned self] bookmarksState in
                switch bookmarksState {
                case .success(let items):
                    print("items count \(items.count)")
                    self.bookmarks = items
                    break
                case .error:
                    print("there was an erorr")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getBookmarks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookmarkToDetails" {
            let detailsVC = segue.destination as! NewsDetailViewController
            detailsVC.modalDismissedDelegate = self
            detailsVC.newsItem = sender as? NewsProjection.NewsItem
        }
    }
    

}

extension BookmarksViewController: ModalDismissedDelegate{
    func modalDidDismissed() {
        viewModel?.getBookmarks()
    }
}

extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsItem = bookmarks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        cell.newsItem = newsItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row \(indexPath.row)")
        let newsItem = bookmarks[indexPath.row]
        performSegue(withIdentifier: "BookmarkToDetails", sender: newsItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
