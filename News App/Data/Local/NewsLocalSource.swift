//
//  NewsLocalSource.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol INewsLocalSource {
    func getNews() -> Single<[News]>
    func saveNews(news: News) -> Single<News>
    func deleteNews(news: News) -> Single<News>
    func getNews(by url: String) -> Single<News>
}

class NewsLocalSource: INewsLocalSource{
    private let newsDao: INewsDao
    
    init(newsDao: INewsDao) {
        self.newsDao = newsDao
    }
    
    func getNews() -> Single<[News]> {
        return newsDao.getAll()
            .map{ newsEntities -> [News] in
                newsEntities.map{news in news.toDomain()}
            }
    }
    
    func saveNews(news: News) -> Single<News> {
        return Single.just(news)
            .map { news in news.toDbEntity() }
            .flatMap {dbEntity in self.newsDao.save(news: dbEntity)}
            .map { dbEntity in dbEntity.toDomain()}
            .map{ news in
                news.isBookmarked = true
                return news
            }
    }
    
    func deleteNews(news: News) -> Single<News> {
        return Single.just(news)
            .map { news in news.toDbEntity() }
            .flatMap {dbEntity in self.newsDao.delete(news: dbEntity)}
            .map { dbEntity in dbEntity.toDomain()}
            .map{ news in
                news.isBookmarked = false
                return news
            }
    }
    
    func getNews(by url: String) -> Single<News> {
        return newsDao.get(by: url).map { entity in entity.toDomain() }
    }
}
