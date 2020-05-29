//
//  NewsAPI.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsAPI{
    
    struct NewsListResponse: ImmutableMappable{
        let status: String?
        let articles: Array<NewsResponse>?
        
        init(map: Map) throws {
            status = try? map.value("status")
            articles = try? map.value("articles")
        }
    }

    struct NewsResponse: ImmutableMappable{
        let source: NewsSourceResponse?
        let title: String
        let publishedAt: Date?
        let author: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let content: String?
        
        init(map: Map) {
            source = try? map.value("source")
            title = (try? map.value("title")) ?? ""
            publishedAt = try? map.value("publishedAt", using: ISODateTransform())
            author = try? map.value("author")
            description = try? map.value("description")
            url = try? map.value("url")
            urlToImage = try? map.value("urlToImage")
            content = try? map.value("content")
        }
    }

    struct NewsSourceResponse: ImmutableMappable {
        let id: String?
        let name: String?
        let description: String?
        let url: String?
        let category: String?
        let language: String?
        let country: String?
        
        init(map: Map){
            id = try? map.value("id")
            name = try? map.value("name")
            description = try? map.value("description")
            url = try? map.value("url")
            category = try? map.value("category")
            language = try? map.value("language")
            country = try? map.value("country")
        }
    }
}
