//
//  ViewController.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import UIKit
import Alamofire

class MarvelVC: UIViewController {

    var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }
    
    var idHero = Int()
    
    var marvel: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view = MainView()
        title = "Marvel Heroes".uppercased()
        self.mainView?.spinnerIndicator.startAnimating()

        fetchData()
        
        mainView?.collectionView.backgroundColor = .black
        mainView?.collectionView.dataSource = self
        mainView?.collectionView.delegate = self
    }
    
    func fetchData() {
        let urlMarvel = "https://gateway.marvel.com/v1/public/characters?ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7"
        
        AF.request(urlMarvel).responseDecodable(of: Welcome.self) { (response) in
            
            guard let char = response.value else { return }
            let characters = char.data.results
            self.marvel = characters
            self.mainView?.spinnerIndicator.stopAnimating()
            self.mainView?.collectionView.reloadData()
            
            self.searchHero()
        }
    }
    
    func searchHero() {
        print(marvel)
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
        
        let additionalVC = AdditionalVC()
        additionalVC.idHero = String(marvel[indexPath.row].id)
        additionalVC.title = marvel[indexPath.row].name.uppercased()
        navigationController?.pushViewController(additionalVC, animated: true)
    }
}
