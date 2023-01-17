//
//  UIImageViewExtension.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
