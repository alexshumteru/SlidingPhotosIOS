//
//  Board.swift
//  SlidingPhoto
//
//  Created by John Park on 2022-03-16.
//

import Foundation

class Board {
    
    var rows : Int;
    var cols : Int;
    var board : [[Int]]
    
    init(dim : Int){
        
        self.rows = dim;
        self.cols = dim;
        
        self.board = []
        for y in 0..<self.rows{
            self.board.append([Int]())
            for x in 0..<self.cols{
                self.board[y].append(self.cols * y + x);
                
            }
        }
        
    }
}
