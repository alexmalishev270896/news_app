//
//  NewsView.swift
//  News App
//
//  Created by Александр Малышев on 14.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit
import Nuke

class NewsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    private let options = ImageLoadingOptions(
      placeholder: UIImage(named: "placeholder"),
      transition: .fadeIn(duration: 0.5)
    )
    
    var newsItem: NewsProjection.NewsItem! {
        didSet {
            sourceName.text = newsItem.sourceName
            articleDescription.text = newsItem.title
            date.text = newsItem.formattedDate(format: "HH:mm MMMM dd, yyyy")
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
        Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
