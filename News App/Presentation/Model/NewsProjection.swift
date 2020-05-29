//
//  NewsPresentation.swift
//  News App
//
//  Created by Александр Малышев on 14.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

class NewsProjection{
    
    struct NewsItem {
        let title: String
        let date: Date?
        let description: String
        let url: String
        let imageUrl: String
        let content: String
        let sourceName: String?
        let author: String
        let isBookmarked: Bool
    }
}

extension NewsProjection.NewsItem{
    func formattedDate(format: String) -> String?{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        guard let d = date else { return nil }
        return dateFormatterPrint.string(from: d)
    }
}
