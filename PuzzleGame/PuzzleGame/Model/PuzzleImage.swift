//
//  Puzzle.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 21/01/22.
//

import Foundation
import UIKit
import CoreImage

class PuzzleImage {
    
    var image: CGImage
    
    init(_ image: CGImage){
        self.image = image
    }
    
    func getPuzzleImage() -> CGImage {
        return image
    }
    
    func setNewPuzzleImage(_ newImage: CGImage) {
        self.image = newImage
    }
    
    func divide(times: Int) -> [CGImage] {
        var tiles: [CGImage] = []
        let image: CGImage = image
        
        for x in 0..<times {
            for y in 0..<times {

                let tile = image.cropping(to: CGRect(x: x * (image.width)/times, y: y * (image.height)/times, width: (image.width) / times, height: (image.height) / times ))
                tiles.append(tile!)

            }
        }
        return tiles
     }
    
}

