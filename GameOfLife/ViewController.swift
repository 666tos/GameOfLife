//
//  ViewController.swift
//  GameOfLife
//
//  Created by M Ivaniushchenko on 23.07.2020.
//  Copyright © 2020 xelion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private struct Constant {
        static let numberOfRows = 10
        static let numberOfColumns = 10
    }
    
    @IBOutlet private var renderView: RenderView!
    
    private let game = Game.glider(numberOfRows: Constant.numberOfRows, numberOfColumns: Constant.numberOfColumns)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.renderBoard()
    }

    @IBAction private func onIterateButtonPressed() {
        self.game.iterate()
        
        self.renderBoard()
    }
    
    private func renderBoard() {
        self.renderView.board = self.game.board
    }
}

