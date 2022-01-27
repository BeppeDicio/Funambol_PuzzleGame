//
//  Utility.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 27/01/22.
//

import UIKit

class Utility {
    
    func convertCIImageToCGImage(_ inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
}
