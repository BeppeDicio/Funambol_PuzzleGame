//
//  ViewController.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 21/01/22.
//

import UIKit

class ViewController: UIViewController {

    let urlSrtings = URLStrings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = NSURL(string: urlSrtings.random1024ImagesURL)
        let imagedData = NSData(contentsOf: imageURL! as URL)!
        let image = UIImage(data: imagedData as Data)
        
        
        if image != nil {
            let ciImage = CIImage(image: image!)!
            let cgImage = convertCIImageToCGImage(ciImage)!
            let puzzleImage = PuzzleImage(cgImage)
            let solvedImages = puzzleImage.divide(times: 9)
            var puzzle = Puzzle(title: puzzleImage.image, solvedImage: solvedImages)
        }
        
    }
    
    func convertCIImageToCGImage(_ inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        if context != nil {
            return context.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
}

