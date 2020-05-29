//
//  GetSavedNewsUseCase.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol IGetSavedNewsUseCase {
    func execute() -> Single<[News]>
}

class GetSavedNewsUseCase: IGetSavedNewsUseCase {
    
    private let newsRepository: INewsRepository
    
    init(repository: INewsRepository) {
        self.newsRepository = repository
    }
    
    func execute() -> Single<[News]> {
        return newsRepository.getSavedNews()
    }
}
