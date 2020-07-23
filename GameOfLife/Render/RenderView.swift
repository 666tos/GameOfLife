//
//  RenderView.swift
//  GameOfLife
//
//  Created by M Ivaniushchenko on 23.07.2020.
//  Copyright © 2020 xelion. All rights reserved.
//

import UIKit

class RenderView: UIView {
    private struct Constant {
        static let gridColor = UIColor.black
        static let deadCellColor = UIColor.white
        static let aliveCellColor = UIColor.red
        static let gridLineWidth = CGFloat(1.0)
    }
    
    var board: Board? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.fillBackground()
        
        guard let board = self.board else {
            return
        }
                
        let numberOfRows = CGFloat(board.numberOfRows)
        let numberOfColumns = CGFloat(board.numberOfColumns)
        
        let cellWidth = (self.bounds.width - Constant.gridLineWidth * (numberOfColumns - 1)) / numberOfColumns
        let cellHeight = (self.bounds.height - Constant.gridLineWidth * (numberOfRows - 1)) / numberOfRows
        
        let cellSize = min(cellWidth, cellHeight).rounded(.down)
        
        let originX = (self.bounds.width - cellSize * numberOfColumns - Constant.gridLineWidth * (numberOfColumns - 1)) / 2
        let originY = (self.bounds.height - cellSize * numberOfRows - Constant.gridLineWidth * (numberOfRows - 1)) / 2
        
        board.enumerate { (indexPath: IndexPath, cell: Cell) in
            let column = CGFloat(indexPath.column)
            let row = CGFloat(indexPath.row)
            let color = self.color(for: cell)
            
            let rect = CGRect(x: originX + cellSize * column + Constant.gridLineWidth * (column - 1),
                              y: originY + cellSize * row + Constant.gridLineWidth * (row - 1),
                              width: cellSize,
                              height: cellSize)
            
            let bezierPath = UIBezierPath(rect: rect)
            color.setFill()
            bezierPath.fill()
        }
    }
    
    private func fillBackground() {
        let bezierPath = UIBezierPath(rect: self.bounds)
        Constant.gridColor.setFill()
        bezierPath.fill()
    }
    
    private func color(for cell: Cell) -> UIColor {
        switch cell.state {
            case .alive:    return Constant.aliveCellColor
            case .dead:    return Constant.deadCellColor
        }
    }
}
