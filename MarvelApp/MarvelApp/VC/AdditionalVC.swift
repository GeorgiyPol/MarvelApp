//
//  AdditionalVC.swift
//  MarvelApp
//
//  Created by Georgiy on 21.01.2023.
//

import Foundation
import UIKit
import Alamofire

class AdditionalVC: UIViewController {
        
    var additionalView: AdditionalView? {
        guard isViewLoaded else { return nil }
        return view as? AdditionalView
    }

    var idHero: String = ""
    var marvel: [ResultHero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = AdditionalView()
        view.backgroundColor = .black
        
        getData()
    }
    
    func getData() {
        
        
                
        let urlMarvel =
            "https://gateway.marvel.com/v1/public/characters/" +
            "\(self.idHero)" +
            "/comics?ts=10&apikey=31a63b3b088f1225ef9e5d5f56a97b85&hash=070548dfe73f5680972208e2cb02f1f7"
        
        
        AF.request(urlMarvel).responseDecodable(of: MarvelHero.self) { (response) in // поменять модель декодирования
            
            guard let char = response.value else { return }
            let hero = char.data.results
            self.marvel = hero
            self.additionalView?.configureAddView(hero: self.marvel.first)
        }
    }
}
