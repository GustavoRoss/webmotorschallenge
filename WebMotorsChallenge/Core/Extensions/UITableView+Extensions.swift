//
//  UITableView+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 05/07/22.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! T
    }
}
