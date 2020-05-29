//
//  BaseConfigurator.swift
//  News App
//
//  Created by Александр Малышев on 15.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation
import UIKit

class BaseConfigurator<T: UIViewController>{
    open func configure(with viewController: T){
        fatalError("Method must be overriden")
    }
}
