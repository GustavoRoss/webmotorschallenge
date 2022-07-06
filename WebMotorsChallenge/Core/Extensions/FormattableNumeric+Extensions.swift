//
//  FormattableNumeric+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 06/07/22.
//

import Foundation

protocol FormattableNumeric {
    
}

extension Int: FormattableNumeric {}
extension UInt: FormattableNumeric {}
extension Float: FormattableNumeric {}
extension Double: FormattableNumeric {}
extension NSNumber: FormattableNumeric {}

extension FormattableNumeric {
    
    func toDecimalCoin() -> String {
        let value = Double(truncating: self as? NSNumber ?? 0)
        let divider = Double(100)
        let result = value / divider
        return result.toCoin()
    }
    
    func toCoin(with locale: Locale = Locale(identifier: "pt_BR")) -> String {
        let numberFormatter = NumberFormatter().apply {
            $0.numberStyle = .currency
            $0.maximumFractionDigits = 2
            $0.locale = locale
            $0.alwaysShowsDecimalSeparator = true
        }
        
        return numberFormatter.string(for: self)!
    }
}
