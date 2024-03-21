//
//  PuzzleLogic.swift
//  Ind02_Chirudeep_Tupakula
//
//  Created by Sandeep Nuthi on 3/21/24.
//

import Foundation
import UIKit

class PuzzleLogic {
    var images: [UIImage?] = []
    var emptySlotIndex: Int = 19 // Starting from 0, so 20th position.

    init(images: [UIImage?]) {
        self.images = images
    }

    func isAdjacent(to index: Int) -> Bool {
        let row = index / 4
        let col = index % 4
        let emptyRow = emptySlotIndex / 4
        let emptyCol = emptySlotIndex % 4
        return abs(row - emptyRow) + abs(col - emptyCol) == 1
    }

    func swapWithEmptySlot(_ index: Int) {
        images.swapAt(index, emptySlotIndex)
        emptySlotIndex = index
    }

    func shuffleTiles() {
        for _ in 0..<(10 + Int(arc4random_uniform(16))) { // Shuffle between 10 to 25 times
            var adjacentTiles: [Int] = []
            let positions = [-1, 1, -4, 4] // left, right, up, down
            for pos in positions {
                let newIndex = emptySlotIndex + pos
                if newIndex >= 0 && newIndex < images.count && isAdjacent(to: newIndex) {
                    adjacentTiles.append(newIndex)
                }
            }
            if let randomTile = adjacentTiles.randomElement() {
                swapWithEmptySlot(randomTile)
            }
        }
    }
}
