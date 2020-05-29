//
//  NewsDetailModule.swift
//  News App
//
//  Created by Александр Малышев on 20.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

class NewsDetailConfigurator: BaseConfigurator<NewsDetailViewController>{
    
    override func configure(with viewController: NewsDetailViewController) {
        let newsDao = NewsDao()
        let newsRemoteSource = NewsRemoteSource()
        let newsLocalSource = NewsLocalSource(newsDao: newsDao)
        let newsRepository = NewsRepository(remoteSource: newsRemoteSource, newsLocalSource: newsLocalSource)
        let checkNewsExists = CheckNewsExistsUseCase(repository: newsRepository)
        let saveNews = SaveNewsUseCase(repository: newsRepository)
        let deleteNews = DeleteNewsUseCase(repository: newsRepository)
        viewController.viewModel = NewsDetailViewModel(checkNews: checkNewsExists, saveNews: saveNews, deleteNews: deleteNews, provider: SchedulerProvider())
    }
}
