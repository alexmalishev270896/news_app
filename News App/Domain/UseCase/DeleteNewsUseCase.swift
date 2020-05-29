//
//  DeleteNewsUseCase.swift
//  News App
//
//  Created by Александр Малышев on 19.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol IDeleteNewsUseCase {
    func execute(news: News) -> Single<News>
}

class DeleteNewsUseCase: IDeleteNewsUseCase {
    private let newsRepository: INewsRepository
    
    init(repository: INewsRepository) {
        self.newsRepository = repository
    }
    
    func execute(news: News) -> Single<News> {
        return newsRepository.deleteNews(news: news)
    }
}
