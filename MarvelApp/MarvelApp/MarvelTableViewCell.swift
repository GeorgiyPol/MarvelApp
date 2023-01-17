//
//  MarvelTableViewCell.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import UIKit

class MarvelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    var marvelCharacter: Result! {
        didSet {
            //self.labelName.text = self.marvelCharacter.name
            self.img.setImage(imageUrl: self.marvelCharacter.getThumbnailUrl())
        }
    }
}
