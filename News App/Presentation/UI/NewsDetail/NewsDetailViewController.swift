//
//  NewsDetailViewController.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit
import Nuke
import SafariServices
import RxSwift

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var openSafariButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var newsItem: NewsProjection.NewsItem?
    var viewModel: INewsDetailViewModel?
    var modalDismissedDelegate: ModalDismissedDelegate? = nil
    
    private let configurator: BaseConfigurator = NewsDetailConfigurator()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        openSafariButton.layer.cornerRadius = CGFloat(12)
        displayNewsItem()
        
        viewModel?.newsDetail
            .drive(onNext: {[unowned self] newsItemState in
                switch newsItemState {
                case .success(let item):
                    self.newsItem = item
                    self.displayNewsItem()
                    break
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        if let item = newsItem {
            viewModel?.checkExists(news: item)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        modalDismissedDelegate?.modalDidDismissed()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        modalDismissedDelegate?.modalDidDismissed()
    }
    
    private func displayNewsItem(){
        newsTitleLabel.text = newsItem?.title
        newsAuthorLabel.text = newsItem?.author
        newsSourceLabel.text = newsItem?.sourceName
        newsDateLabel.text = newsItem?.formattedDate(format: "HH:MM, dd MMMM YYYY")
        bookmarkButton.isSelected = newsItem?.isBookmarked ?? false
        newsContentLabel.text = newsItem?.content
        if let urlString = newsItem?.imageUrl, let url = URL(string: urlString){
            Nuke.loadImage(with: url, into: newsImageView)
        }
    }
    
    @IBAction func openSafariTapped(_ sender: Any) {
        if let newsItem = newsItem, let newsUrl = URL(string: newsItem.url) {
            let safariVC = SFSafariViewController(url: newsUrl)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func bookmarkTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if newsItem != nil {
            if sender.isSelected {
                viewModel?.saveNews(news: newsItem!)
            }else {
                viewModel?.deleteNews(news: newsItem!)
            }
        }
    }
}
