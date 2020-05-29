//
//  News.swift
//  News App
//
//  Created by Александр Малышев on 13.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

class News {
    let title: String
    let date: Date?
    let author: String
    let description: String
    let url: String
    let imageUrl: String
    let content: String
    let source: NewsSource?
    var isBookmarked: Bool = false
    
    init(title: String,
         date: Date? = nil,
         author: String,
         description: String,
         url: String,
         imageUrl: String,
         content: String,
         source: NewsSource? = nil,
         isBookmarked: Bool = false) {
        
        self.title = title
        self.date = date
        self.author = author
        self.description = description
        self.url = url
        self.imageUrl = imageUrl
        self.content = content
        self.source = source
        self.isBookmarked = isBookmarked
    }
}

struct NewsSource{
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
    
    init(id: String?, name: String?, description: String?, url: String?, category: String?, language: String?, country: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
    
    init(name: String?) {
        self.init(id: nil, name: name, description: nil, url: nil, category: nil, language: nil, country: nil)
    }
}
