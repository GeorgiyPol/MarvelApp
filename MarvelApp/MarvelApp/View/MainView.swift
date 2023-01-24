//
//  MainView.swift
//  MarvelApp
//
//  Created by Georgiy on 24.01.2023.
//

import Foundation
import UIKit
import SwiftUI

class MainView: UIView {
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = .systemGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var spinnerIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
        return collectionView
    }()
    
    lazy var separatorLine: UIView = {
        let separator = UIView()
        separator.backgroundColor = .yellow
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private func createLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.35))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    init() {
        super .init(frame: .zero)
        
        setupHierarchy()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(searchTextField)
        addSubview(separatorLine)
        addSubview(spinnerIndicator)
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            searchTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            searchTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 5),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)

        ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5),
            separatorLine.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            separatorLine.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            separatorLine.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        NSLayoutConstraint.activate([
            spinnerIndicator.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor),
            spinnerIndicator.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        
        
        
    }
    
    private func setupView() {
        clipsToBounds = true
    }
}