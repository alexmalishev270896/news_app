//
//  SearchNewsUseCase.swift
//  News App
//
//  Created by Александр Малышев on 18.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol ISearchNewsUseCase {
    func execute(_ query: String) -> Single<[News]>
}

class SearchNewsUseCase: ISearchNewsUseCase {
    private let newsRepository: INewsRepository
    
    init(repository: INewsRepository) {
        self.newsRepository = repository
    }
    
    func execute(_ query: String) -> Single<[News]> {
        return newsRepository.getNews(by: query)
    }
}
