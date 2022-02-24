//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Mehdi MMS on 23/02/2022.
//

import UIKit

protocol FilterSelectionDelegate: class {
    func selected(faction: String)
}

class FilterViewController: UIViewController {

    weak var delegate: FilterSelectionDelegate?
    
    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.selected(faction: "sith")
        self.dismiss(animated: true)
    }
    
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.selected(faction: "jedi")
        self.dismiss(animated: true)
    }
}
