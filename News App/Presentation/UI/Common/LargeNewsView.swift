//
//  LargeNewsView.swift
//  News App
//
//  Created by Александр Малышев on 26.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit
import Nuke

class LargeNewsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    private let options = ImageLoadingOptions(
      placeholder: UIImage(named: "placeholder"),
      transition: .fadeIn(duration: 0.5)
    )
    
    var newsItem: NewsProjection.NewsItem! {
        didSet {
            sourceName.text = newsItem.sourceName
            articleTitle.text = newsItem.title
            if let url = URL(string: newsItem.imageUrl){
                newsImage.clipsToBounds = true
                newsImage.layer.cornerRadius = CGFloat(16)
                Nuke.loadImage(with: url, options: options, into: newsImage)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize(){
        Bundle.main.loadNibNamed("LargeNewsView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        articleTitle.layer.shadowRadius = 5.0
        articleTitle.layer.shadowOpacity = 0.8
        sourceName.layer.shadowRadius = 5.0
        sourceName.layer.shadowOpacity = 0.8
    }

}
