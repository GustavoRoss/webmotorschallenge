//
//  PriceLayer.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 05/07/22.
//

import Foundation
import UIKit

class PriceLayer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width * 0.75, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        path.close()
        UIColor(red: 0.78, green: 0.00, blue: 0.22, alpha: 1.00).set()
        path.stroke()
        path.fill()
    }
}
