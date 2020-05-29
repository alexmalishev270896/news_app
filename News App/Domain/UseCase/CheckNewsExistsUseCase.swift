//
//  CheckNewsExistsUseCase.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol ICheckNewsExistsUseCase {
    func execute(news: News) -> Single<News>
}

class CheckNewsExistsUseCase: ICheckNewsExistsUseCase {
    private let newsRepository: INewsRepository
    
    init(repository: INewsRepository) {
        self.newsRepository = repository
    }
    
    func execute(news: News) -> Single<News> {
        return newsRepository.isNewsSaved(news: news)
            .map{ isExists in
                news.isBookmarked = isExists
                return news
            }
    }
}
