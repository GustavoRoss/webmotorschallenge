//
//  UIImageView+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 05/07/22.
//

import Foundation
import Kingfisher

extension UIImageView {
    func load(from url: String?) {
        guard let url = url else { return }
        var httpsUrl = URLComponents(string: url)
        httpsUrl?.scheme = "https"
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: httpsUrl?.string ?? ""))
    }
}

