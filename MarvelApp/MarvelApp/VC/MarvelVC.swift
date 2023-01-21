//
//  ViewController.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import UIKit
import Alamofire

class MarvelVC: UIViewController {

    var collectionView: UICollectionView!
    
    private lazy var spinnerIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let urlMarvel = "https://gateway.marvel.com/v1/public/characters?ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7"
    //http://gateway.marvel.com/v1/public/characters/1011334?ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7
    var marvel: [Result] = []
    
    override func loadView() {
        super.loadView()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Marvel Heroes".uppercased()
        
        fetchData()
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
    }
    
    func fetchData() {
        spinnerIndicator.startAnimating()
        AF.request(self.urlMarvel).responseDecodable(of: Welcome.self) { (response) in
            
            guard let char = response.value else { return }
            
            let characters = char.data.results
            self.marvel = characters
            
            self.spinnerIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
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
}

extension MarvelVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marvel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.marvelCharacter = self.marvel[indexPath.row]
        return cell
    }
}

extension MarvelVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row + 1)
        
        navigationController?.present(AdditionalVC(), animated: true, completion: nil)
    }
}
