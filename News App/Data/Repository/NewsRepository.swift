//
//  NewsRepository.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

class NewsRepository : INewsRepository{
    
    private let newsRemoteSource: INewsRemoteSource
    private let newsLocalSource: INewsLocalSource
    
    init(remoteSource: INewsRemoteSource, newsLocalSource: INewsLocalSource) {
        self.newsRemoteSource = remoteSource
        self.newsLocalSource = newsLocalSource
    }
    
    func getRecentNews() -> Single<Array<News>> {
        return newsRemoteSource.getRecentNews()
            .map{ newsResponse -> Array<News> in newsResponse.toDomainArray()}
    }
    
    func getNews(by query: String) -> Single<Array<News>> {
        return newsRemoteSource.everithing(query)
            .map{newsResponse -> [News] in newsResponse.toDomainArray()}
    }
    
    func getSavedNews() -> Single<[News]> {
        return newsLocalSource.getNews()
    }
    
    func saveNews(news: News) -> Single<News> {
        return newsLocalSource.saveNews(news: news)
    }
    
    func deleteNews(news: News) -> Single<News> {
        return newsLocalSource.deleteNews(news: news)
    }
    
    func isNewsSaved(news: News) -> Single<Bool> {
        return newsLocalSource.getNews(by: news.url)
            .map { news in true }
            .catchErrorJustReturn(false)
    }
}
