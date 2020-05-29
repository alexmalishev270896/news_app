//
//  NewsDao.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

protocol INewsDao {
    func save(news: NewsEntity) -> Single<NewsEntity>
    func delete(news: NewsEntity) -> Single<NewsEntity>
    func getAll() -> Single<[NewsEntity]>
    func get(by url: String) -> Single<NewsEntity>
}

class NewsDao: INewsDao {
    
    private var realm: Realm {
        return try! Realm()
    }
    
    func save(news: NewsEntity) -> Single<NewsEntity> {
        return self.realm.rx.save(entity: news).asSingle()
    }
    
    func delete(news: NewsEntity) -> Single<NewsEntity> {
        return self.realm.rx.delete(entity: news, by: news.url).asSingle()
    }
    
    func getAll() -> Single<[NewsEntity]> {
        return Single.deferred {
            let news = self.realm.objects(NewsEntity.self)
            return Single.just(news.toArray())
        }
    }
    
    func get(by url: String) -> Single<NewsEntity> {
        return Single.deferred {
            guard let item = self.realm.object(ofType: NewsEntity.self, forPrimaryKey: url) else {
                return Single.error(NSError())
            }
            return Single.just(item)
        }
    }
}
