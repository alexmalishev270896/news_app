//
//  NewsRepository.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import RxSwift

protocol INewsRepository {
    
    func getRecentNews() -> Single<Array<News>>
    
    func getNews(by query: String) -> Single<Array<News>>
    
    func getSavedNews() -> Single<[News]>
    
    func saveNews(news: News) -> Single<News>
    
    func deleteNews(news: News) -> Single<News>
    
    func isNewsSaved(news: News) -> Single<Bool>
}
