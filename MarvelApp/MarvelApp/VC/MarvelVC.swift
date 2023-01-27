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
    var marvelDuplicate: [Result] = []
    var marvelForTextField: [Result] = []
    
///https://gateway.marvel.com/v1/public/characters?
    ///ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7
    
///https://gateway.marvel.com/v1/public/characters?name=A&ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = MainView()
        title = "Marvel Heroes".uppercased()
        self.mainView?.spinnerIndicator.startAnimating()

        fetchData(with: makeUrlString())

        mainView?.collectionView.backgroundColor = .black
        mainView?.collectionView.dataSource = self
        mainView?.collectionView.delegate = self
    }

    func fetchData(with url: String) {

        AF.request(url).responseDecodable(of: Welcome.self) { (response) in

            guard let char = response.value else { return }
            let characters = char.data.results
            self.marvel = characters
            self.marvelDuplicate = self.marvel
    
            self.mainView?.spinnerIndicator.stopAnimating()
            self.mainView?.collectionView.reloadData()

            self.mainView?.searchTextField.addTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
        }
    }

    @objc func editingChanged(_ textField: UITextField) {
        let textFieldString = textField.text ?? "Some string?"
        print(makeUrlStringTest(name: textFieldString))
        
        if textFieldString.isEmpty {
            marvel = marvelDuplicate
            self.mainView?.collectionView.reloadData()
            marvelForTextField.removeAll()
        }
        
        AF.request(makeUrlStringTest(name: textFieldString)).responseDecodable(of: Welcome.self) { (response) in
            
            guard let char = response.value else { return }
            let characters = char.data.results
            self.marvel = characters
            
            self.mainView?.spinnerIndicator.stopAnimating()
            self.mainView?.collectionView.reloadData()
        }
    }
}

extension MarvelVC {
    func makeUrlString() -> String {
        let marvelStruct = MarvelStruct()
        let hash = marvelStruct.MD5(string: marvelStruct.dataToMD5)

        let queryItemsMarvel = [
            URLQueryItem(name: "ts", value: marvelStruct.ts),
            URLQueryItem(name: "apikey", value: marvelStruct.publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        let tryCreateMarvelURL = marvelStruct.makeURL(scheme: marvelStruct.marvelScheme,
                                         host: marvelStruct.marvelHost,
                                         path: marvelStruct.marvelPath,
                                         queryItems: queryItemsMarvel)
        return tryCreateMarvelURL
    }
    
    func makeUrlStringTest(name: String) -> String {
        let customURL = "https://gateway.marvel.com/v1/public/characters?name=\(name)&ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7"
        return customURL
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
