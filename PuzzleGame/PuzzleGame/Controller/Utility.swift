//
//  Utility.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 27/01/22.
//

import UIKit

class Utility {
    
    func divide(times: Int, image: UIImage) -> [UIImage] {
        
        var tiles: [UIImage] = []
        let ciImage = CIImage(image: image)!
        let cgImage = convertCIImageToCGImage(ciImage)!
        
        for x in 0..<times {
            for y in 0..<times {

                let tile = cgImage.cropping(to: CGRect(x: x * (cgImage.width)/times, y: y * (cgImage.height)/times, width: (cgImage.width) / times, height: (cgImage.height) / times ))
                tiles.append(UIImage(cgImage: tile!))

            }
        }
        return tiles
     }
    
    func convertCIImageToCGImage(_ inputImage: CIImage) -> CGImage! {
        
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
    
    func arrayOfUIImageAreEqual(firstArray: [UIImage], secondArray: [UIImage]) -> Bool {
        
        if firstArray.count != secondArray.count {
            
            return false
        }
        
        for index in 0..<firstArray.count {
            
            if firstArray[index].pngData() != secondArray[index].pngData(){
                return false
            }
        }
        
        return true
    }
}
