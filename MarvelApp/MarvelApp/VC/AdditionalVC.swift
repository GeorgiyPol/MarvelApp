//
//  AdditionalVC.swift
//  MarvelApp
//
//  Created by Georgiy on 21.01.2023.
//

import Foundation

import UIKit

class AdditionalVC: UIViewController {

    var additionalView: AdditionalView? {
        guard isViewLoaded else { return nil }
        return view as? AdditionalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = AdditionalView()
        view.backgroundColor = .black
        title = "Hero name".uppercased()
    }
}
