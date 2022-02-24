//
//  CharacterCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Mehdi MMS on 23/02/2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    func displayImage(for character: Character) {
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.image = character.photo
    }
}
