//
//  CardCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Mehdi MMS on 23/02/2022.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
    
    private var displayedCharacters: [Character] = []
    private var targetCharacter: Character?
    private var selectedFaction = "jedi"

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCharacters(for: selectedFaction)
    }
    
    func shuffleCharacters(for faction: String) {
        if faction == "sith" {
            let sithGroup = CharacterController.sith.prefix(3)
            targetCharacter = CharacterController.jedi.randomElement()
            displayedCharacters = Array(sithGroup)
        } else if faction == "jedi" {
            let jediGroup = CharacterController.jedi.prefix(3)
            targetCharacter = CharacterController.sith.randomElement()
            displayedCharacters = Array(jediGroup)
        }
        
        updateViews()
    }
    
    private func updateViews() {
        guard let target = targetCharacter else { return }
        displayedCharacters.append(target)
        displayedCharacters.shuffle()
        title = "Find \(target.name)"
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return displayedCharacters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        let character = displayedCharacters[indexPath.row]
        
        cell.displayImage(for: character)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = displayedCharacters[indexPath.row]
        presentAlert(for: selectedCharacter)
    }
    
    func presentAlert(for character: Character) {
        let success = character == targetCharacter
        let alertController = UIAlertController(title: success ? "Good Job!" : "Better luck next time", message: nil, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Suffle!", style: .default) { _ in
            self.shuffleCharacters(for: self.selectedFaction)
        }
        
        alertController.addAction(doneAction)
        
        if success {
            alertController.addAction(shuffleAction)
        }
        
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterVC" {
            let vc = segue.destination as? FilterViewController
            vc?.delegate = self
        }
    }
}

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 15, height: width + 30)
    }
}

extension CardCollectionViewController: FilterSelectionDelegate {
    func selected(faction: String) {
        selectedFaction = faction
        shuffleCharacters(for: faction)
    }
}
