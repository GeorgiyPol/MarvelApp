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
        label.textColor = .white
        label.font = UIFont(name:"marvel-regular", size: 15.0)
        return label
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.layer.borderWidth = 3
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
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
        
        contentView.clipsToBounds = true
        
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        contentView.addSubview(stack)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            stack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
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
