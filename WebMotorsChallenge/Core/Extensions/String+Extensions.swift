//
//  String+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation

extension String {
    
    var url: URL {
        guard let url = URL(string: self) else {
            fatalError("This string \(self) cannot be a URL")
        }
        return url
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
}
