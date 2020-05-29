//
//  LargeNewsCell.swift
//  News App
//
//  Created by Александр Малышев on 26.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit

class LargeNewsCell: UITableViewCell{
    @IBOutlet weak var newsView: LargeNewsView!
    
    var newsItem: NewsProjection.NewsItem!{
        didSet{
            newsView.newsItem = newsItem
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        shrink(down: highlighted)
    }
    
    private func shrink(down: Bool) {
        UIView.animate(withDuration: 0.6) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        }
    }
}
