//
//  GameScene.swift
//  testt
//
//  Created by Yassir RAMDANI on 4/30/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import SpriteKit

let CellSize: CGFloat = 2
class GameScene: SKScene {
    var grid = [GOLCell]()
    let emptyCell = GOLCell(position: .zero)
    lazy var cellsPerLine = Int(view!.bounds.width / (CellSize + 0.5))
    lazy var cellsPerCollumn = Int(view!.bounds.height/(CellSize + 0.5))
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        for y in 0..<cellsPerCollumn{
            for x in 0..<cellsPerLine{
                let newCell = GOLCell(position: CGPoint(x: CGFloat(x) * (CellSize + 0.5), y: CGFloat(y) * (CellSize + 0.5)), living: x==100 || x == 200 || y == 100 || y == 200)
                addChild(newCell)
                grid.append(newCell)
            }
        }
        let life = SKAction.run {
            self.nextGeneration()
        }
        let wait = SKAction.wait(forDuration: 0.5)
        run(SKAction.repeatForever(SKAction.sequence([life, wait])))
    }
    
    func cellAt(x: Int, y: Int) -> GOLCell {
        if x < 0 || y < 0 || x >= cellsPerLine || y >= cellsPerCollumn {
            return emptyCell
        }
        return grid[x + y * cellsPerLine]
    }
    
    func nextGeneration() {
        for y in 0..<cellsPerCollumn {
            for x in 0..<cellsPerLine {
                let nbNeighbours = cellAt(x: x - 1, y: y).livingVal() + cellAt(x: x + 1, y: y).livingVal() +
                    cellAt(x: x, y: y + 1).livingVal() + cellAt(x: x, y: y - 1).livingVal() +
                    cellAt(x: x + 1, y: y + 1).livingVal() + cellAt(x: x - 1, y: y - 1).livingVal() +
                    cellAt(x: x - 1, y: y + 1).livingVal() + cellAt(x: x + 1, y: y - 1).livingVal()
                let currentCell = cellAt(x: x, y: y)
                if currentCell.living && nbNeighbours < 2 {
                    currentCell.living = false
                }
                if currentCell.living && nbNeighbours > 3 {
                    currentCell.living = false
                }
                if !currentCell.living && nbNeighbours == 3 {
                    currentCell.living = true
                }
            }
        }
    }
}
