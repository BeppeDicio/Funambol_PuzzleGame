//
//  ViewController.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 21/01/22.
//

import UIKit

class HomeViewController: UIViewController {

    let urlSrtings = URLStrings()
    let utility = Utility()
    var puzzleList = [Puzzle]()
    var hintImage = UIImageView()
    let gameSettings = GameSettings()
    var gameNumber = 0
    var gameTimer: Timer?
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Collection view settings
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        
        imagePicker.delegate = self
        
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
        
        puzzleHintButton.isEnabled = true
        collectionView.reloadData()
    }
    
    func addNewPuzzle(image: UIImage){
        
        if image != nil {
            let solvedImages = utility.divide(times: gameSettings.gridColums, image: image)
            puzzleList.append(Puzzle(image: image, solvedImages: solvedImages))
        }
        
        puzzleHintButton.isEnabled = true
        gameNumber += 1
        collectionView.reloadData()
    }
    
    @IBAction func newRandomPuzzle(_ sender: UIButton) {
        
        gameNumber += 1
        addNewPuzzle()
    }
    
    @IBOutlet weak var puzzleHintButton: UIButton!
    @IBAction func puzzleHint(_ sender: UIButton) {
        
        hintImage.image = self.puzzleList[gameNumber].image
        hintImage.backgroundColor = .white
        hintImage.contentMode = .scaleAspectFit
        hintImage.frame = self.view.frame
        self.view.addSubview(hintImage)
        self.collectionView.isHidden = true
        self.view.bringSubviewToFront(hintImage)
        gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(removeHintImage), userInfo: nil, repeats: false)
    }
    
    @IBAction func newPuzzleFromLibrary(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func removeHintImage() {
        self.view.sendSubviewToBack(hintImage)
        self.collectionView.isHidden = false
        self.hintImage.removeFromSuperview()
        puzzleHintButton.isEnabled = false
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            addNewPuzzle(image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameSettings.getTotalGrid()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.puzzleImage.image = puzzleList[gameNumber].unsolvedImages[indexPath.item]
        
        return cell
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

extension HomeViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.puzzleList[gameNumber].unsolvedImages[indexPath.item]
        let itemProvider = NSItemProvider(object: item as UIImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = dragItem
        return [dragItem]
    }
}

extension HomeViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
        
        if utility.arrayOfUIImageAreEqual(firstArray: self.puzzleList[gameNumber].unsolvedImages, secondArray: self.puzzleList[gameNumber].solvedImages) {
            Alert.showSolvedPuzzleAlert(on: self)
            collectionView.dragInteractionEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath:IndexPath, collectionView: UICollectionView) {
        
        if let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath {
            
            collectionView.performBatchUpdates({
                self.puzzleList[gameNumber].unsolvedImages.swapAt(sourceIndexPath.item, destinationIndexPath.item)
                collectionView.reloadItems(at: [sourceIndexPath,destinationIndexPath])
                
            }, completion: nil)
            
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}
