//
//  AdditionalView.swift
//  MarvelApp
//
//  Created by Georgiy on 21.01.2023.
//

import Foundation
import UIKit

class AdditionalView: UIView {
    
    var imageHero: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.layer.borderWidth = 3
        img.contentMode = .scaleAspectFit
        img.tintColor = .white
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.red.cgColor.copy(alpha: 0.5)
        img.image = UIImage(systemName: "person.text.rectangle")
        return img
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name:"marvel-regular", size: 20.0)
        label.text = "This is a Title..."
        return label
    }()
    
    let labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name:"marvel-regular", size: 20.0)
        label.text = "This is a Description..."
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name:"marvel-regular", size: 10.0)
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "This is a Price..."
        label.textAlignment = .right
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupHierarchy()
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        stack.addArrangedSubview(imageHero)
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDescription)
        stack.addArrangedSubview(labelPrice)
        
        addSubview(stack)
    }
    
    private func setupView() {
        clipsToBounds = true
    }
    
    func configureAddView(hero: ResultHero!) {
        self.imageHero.setImage(imageUrl: hero.getThumbnailUrl())
        self.labelTitle.text = hero.title
        self.labelDescription.text = hero.description
        self.labelPrice.text = hero.getComicPrice()
    }
}
