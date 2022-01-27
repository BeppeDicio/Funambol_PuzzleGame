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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = NSURL(string: urlSrtings.random1024ImagesURL)
        let imagedData = NSData(contentsOf: imageURL! as URL)!
        let image = UIImage(data: imagedData as Data)
        
        if image != nil {
            let ciImage = CIImage(image: image!)!
            let cgImage = utility.convertCIImageToCGImage(ciImage)!
            let puzzleImage = PuzzleImage(cgImage)
            let solvedImages = puzzleImage.divide(times: 9)
            var puzzle = Puzzle(title: puzzleImage.image, solvedImage: solvedImages)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.puzzleImage.image = UIImage(named: "default")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //return UIEdgeInsets(top: 40, left: 10, bottom: 40, right: 10)
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        var customCollectionWidth: CGFloat!
        
        customCollectionWidth = 125
        
        return CGSize(width: customCollectionWidth, height: customCollectionWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
