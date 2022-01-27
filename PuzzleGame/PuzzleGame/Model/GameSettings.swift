//
//  GameSettings.swift
//  PuzzleGame
//
//  Created by Giuseppe Diciolla on 27/01/22.
//

import UIKit

class GameSettings {
    
    let gridColums: Int
    let totalGrid: Int
    let squareWidth: CGFloat
    
    init() {
        self.gridColums = 3
        self.totalGrid = gridColums * gridColums
        self.squareWidth = CGFloat(375) / CGFloat(self.gridColums)
    }
    
    func getGridColums() -> Int{
        
        return gridColums
    }
    
    func getTotalGrid() -> Int{
        
        return totalGrid
    }
    
    func getsquareWidth() -> CGFloat{
        
        return squareWidth
    }
}
