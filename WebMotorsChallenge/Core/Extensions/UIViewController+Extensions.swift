//
//  UIViewController+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 28/06/22.
//

import Foundation
import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
            return UIApplication.shared.delegate as! AppDelegate
        }

    var coordinator: AppCoordinator {
        return self.appDelegate.appCoordianator
    }
}
