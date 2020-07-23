//
//  Game.swift
//  GameOfLife
//
//  Created by M Ivaniushchenko on 23.07.2020.
//  Copyright © 2020 xelion. All rights reserved.
//

import Foundation

class Game {   
    private let numberOfRows: Int
    private let numberOfColumns: Int
    private(set) var board: Board
    
    init(numberOfRows: Int, numberOfColumns: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        
        self.board = Board(numberOfRows: numberOfRows, numberOfColumns: numberOfColumns)
    }
    
    static func glider(numberOfRows: Int, numberOfColumns: Int) -> Game {
        let game = Game(numberOfRows: numberOfRows, numberOfColumns: numberOfColumns)
        
        game.board[IndexPath(row: 0, column: 1)].state = .alive
        game.board[IndexPath(row: 1, column: 2)].state = .alive
        game.board[IndexPath(row: 2, column: 0)].state = .alive
        game.board[IndexPath(row: 2, column: 1)].state = .alive
        game.board[IndexPath(row: 2, column: 2)].state = .alive
        
        return game
    }
    
    func iterate() {
        self.board = self.evolve()
    }
    
    private func evolve() -> Board {
        var nextBoard = Board(numberOfRows: self.numberOfRows, numberOfColumns: self.numberOfColumns)
        
        self.board.enumerate { (indexPath: IndexPath, cell: Cell) in
            let numberOfNeighboursAlive = self.countAliveNeighbours(at: indexPath)
            let cellState = self.board[indexPath].state
            
            let nextCellState = self.cellState(for: numberOfNeighboursAlive, currentState: cellState)
            
            nextBoard[indexPath].state = nextCellState
        }
        
        return nextBoard
    }
    
    private func cellState(for numberOfNeighboursAlive: Int, currentState: Cell.State) -> Cell.State {
        switch currentState {
            case .alive:
                switch numberOfNeighboursAlive {
                    case 0..<2:     return .dead
                    case 2...3:     return .alive
                    default:        return .dead
                }
            
            case .dead:
                switch numberOfNeighboursAlive {
                    case 3:         return .alive
                    default:        return .dead
                }
        }
    }
    
    private func countAliveNeighbours(at indexPath: IndexPath) -> Int {
        let minRow = max(indexPath.row - 1, 0)
        let maxRow = min(indexPath.row + 1, self.numberOfRows - 1)
        
        let minColumn = max(indexPath.column - 1, 0)
        let maxColumn = min(indexPath.column + 1, self.numberOfColumns - 1)
        
        var numberOfNeighboursAlive = 0
        
        for row in minRow...maxRow {
            for column in minColumn...maxColumn {
                let currentIndexPath = IndexPath(row: row, column: column)
                
                guard currentIndexPath != indexPath else {
                    continue
                }
                
                let cell = self.board[currentIndexPath]
                
                switch cell.state {
                    case .alive:
                        numberOfNeighboursAlive += 1
                    
                    default: ()
                }
            }
        }
        
        return numberOfNeighboursAlive
    }
}
