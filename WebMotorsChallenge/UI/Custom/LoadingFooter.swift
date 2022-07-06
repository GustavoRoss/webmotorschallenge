//
//  LoadingFooter.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 05/07/22.
//

import Foundation
import SnapKit
import UIKit

class LoadingFooter: UIView {
    
    private let indicator = UIActivityIndicatorView(style: .medium).apply {
        $0.startAnimating()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .black
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(view: indicator) { $0.centerX.centerY.equalToSuperview() }
    }
}
