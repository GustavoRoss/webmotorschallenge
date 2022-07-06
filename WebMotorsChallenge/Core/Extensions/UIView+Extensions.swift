//
//  UIView+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 05/07/22.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    func addSubview(view: UIView, onViewAdded: (ConstraintMaker) -> Void) {
        self.addSubview(view)
        view.snp.makeConstraints(onViewAdded)
    }
}
