//
//  ViewController.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 21/01/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let urlSrtings = URLStrings()
    let utility = Utility()
    var puzzleList = [Puzzle]()
    let gameSettings = GameSettings()
    var gameNumber = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNewPuzzle()
    }
    
    func addNewPuzzle(){
        let imageURL = NSURL(string: urlSrtings.random1024ImagesURL)
        let imagedData = NSData(contentsOf: imageURL! as URL)!
        let image = UIImage(data: imagedData as Data)
        
        if image != nil {
            let solvedImages = utility.divide(times: gameSettings.gridColums, image: image!)
            puzzleList.append(Puzzle(image: image!, solvedImages: solvedImages))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameSettings.getTotalGrid()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.puzzleImage.image = puzzleList[gameNumber].unsolvedImages[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        var customCollectionWidth: CGFloat!
        
        customCollectionWidth = self.gameSettings.getsquareWidth()
        
        return CGSize(width: customCollectionWidth, height: customCollectionWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
