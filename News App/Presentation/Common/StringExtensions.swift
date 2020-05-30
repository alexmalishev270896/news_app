//
//  StringExtensions.swift
//  News App
//
//  Created by Александр Малышев on 30.05.2020.
//  Copyright © 2020 Alex Malishev. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
