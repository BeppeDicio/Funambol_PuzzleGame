//
//  Puzzle.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 24/01/22.
//

import Foundation
import UIKit

class Puzzle {
    
    var title: CGImage
    var solvedImage: [CGImage]
    var unsolvedImage: [CGImage]
    
    init(title: CGImage, solvedImage: [CGImage]){
        self.title = title
        self.solvedImage = solvedImage
        self.unsolvedImage = self.solvedImage.shuffled()
    }
}
