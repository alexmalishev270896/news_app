//
//  RecentNewsModule.swift
//  News App
//
//  Created by Александр Малышев on 15.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation


class RecentNewsConfigurator: BaseConfigurator<RecentNewsViewController>{
    
    override func configure(with viewController: RecentNewsViewController) {
        let newsDao = NewsDao()
        let newsRemoteSource = NewsRemoteSource()
        let newsLocalSource = NewsLocalSource(newsDao: newsDao)
        let newsRepository = NewsRepository(remoteSource: newsRemoteSource, newsLocalSource: newsLocalSource)
        let checkNewsExists = CheckNewsExistsUseCase(repository: newsRepository)
        let useCase = GetRecentNewsUseCase(newsRepository: newsRepository, newsExistsUseCase: checkNewsExists)
        viewController.viewModel = RecentNewsViewModel(getRecentNewsUseCase: useCase)
    }
}
