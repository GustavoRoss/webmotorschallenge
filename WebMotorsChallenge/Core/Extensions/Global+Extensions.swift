//
//  Global+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation

public protocol Appliable {}

extension NSObject: Appliable {}

public extension Appliable {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
