//
//  PlaceholderView.swift
//  News App
//
//  Created by Александр Малышев on 26.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var text: String? {
        didSet{
            textLabel.text = text
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
        Bundle.main.loadNibNamed("PlaceholderView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
