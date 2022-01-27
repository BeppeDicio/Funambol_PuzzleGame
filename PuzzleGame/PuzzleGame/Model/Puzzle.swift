//
//  Puzzle.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 24/01/22.
//

import Foundation
import UIKit

class Puzzle {
    
    var image: UIImage
    var solvedImages: [UIImage]
    var unsolvedImages: [UIImage]
    
    init(image: UIImage, solvedImages: [UIImage]) {
        self.image = image
        self.solvedImages = solvedImages
        self.unsolvedImages = self.solvedImages.shuffled()
    }
}
