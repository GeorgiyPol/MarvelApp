//
//  MyCell.swift
//  MarvelApp
//
//  Created by Georgiy on 19.01.2023.
//

import Foundation
import UIKit
import Kingfisher

class MyCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.layer.borderWidth = 3
        return img
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    var marvelCharacter: Result! {
        didSet {
            self.label.text = self.marvelCharacter.name
            self.imageView.setImage(imageUrl: self.marvelCharacter.getThumbnailUrl())
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        contentView.addSubview(stack)

        contentView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            stack.centerXAnchor.constraint(equalTo:  contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo:  contentView.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
