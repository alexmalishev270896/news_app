//
//  RecentNewsUseCase.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol IGetRecentNewsUseCase: class {
    func execute() -> Single<Array<News>>
}

class GetRecentNewsUseCase : IGetRecentNewsUseCase {
    private let newsRepository: INewsRepository
    private let checkNewsExistsUseCase: ICheckNewsExistsUseCase
    
    init(newsRepository: INewsRepository, newsExistsUseCase: ICheckNewsExistsUseCase) {
        self.newsRepository = newsRepository
        self.checkNewsExistsUseCase = newsExistsUseCase
    }
    
    func execute() -> Single<Array<News>> {
        return newsRepository.getRecentNews()
            .asObservable()
            .flatMap { (news: [News])-> Observable<News> in Observable.from(news)}
            .flatMap { (news: News) -> Observable<News> in
                self.checkNewsExistsUseCase.execute(news: news)
                    .asObservable()
            }.toArray()
    }
}
