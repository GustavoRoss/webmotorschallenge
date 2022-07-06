//
//  SnapKit+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 05/07/22.
//

import Foundation
import SnapKit

extension ConstraintMaker {
    func fillMaxWidth(leftInset: CGFloat = 0, rightInset: CGFloat = 0) {
        self.left.equalToSuperview().inset(leftInset)
        self.right.equalToSuperview().inset(rightInset)
    }
    
    func fillMaxHeight(topInset: CGFloat = 0, bottomInset: CGFloat = 0) {
        self.top.equalToSuperview().inset(topInset)
        self.bottom.equalToSuperview().inset(bottomInset)
    }
}
