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
    var boardState : [[Int]]
    var empty : Int;
    
    init(dim : Int){
        
        self.rows = dim;
        self.cols = dim;
        empty = self.rows * self.cols

        
        self.boardState = []
        for y in 0..<self.rows{
            self.boardState.append([Int]())
            for x in 0..<self.cols{
                self.boardState[y].append(self.cols * y + x + 1);
                // 16 is empty for our case
            }
        }
    }
    
    func scramble() {
        
    }
    
    func swapTiles(fromRow r1: Int, fromCol c1: Int, toRow r2: Int, toCol c2: Int) {
        boardState[r2][c2] = boardState[r1][c1]
        boardState[r1][c1] = empty
        print("boardState:", boardState)
    }
    
    func slideTile(atRow r: Int, atCol c: Int) {
        if (r > self.rows || c > self.cols || r < 0 || c < 0) {
            return
        }
        let res = possibleSlidePosition(atRow: r, atCol: c)
        if (res == "NA") {
            return
        }
        if (res == "LEFT") {
            swapTiles(fromRow: r, fromCol: c, toRow: r, toCol: c-1)

        }
        if (res == "RIGHT") {
            swapTiles(fromRow: r, fromCol: c, toRow: r, toCol: c+1)

        }
        if (res == "UP") {
            swapTiles(fromRow: r, fromCol: c, toRow: r-1, toCol: c)
        }
        if (res == "DOWN") {
            swapTiles(fromRow: r, fromCol: c, toRow: r+1, toCol: c)
        }
    
    }
    
    func possibleSlidePosition(atRow r: Int, atCol c: Int) -> String {
        print("boardState:", boardState)
        print("r:", r)
        print("c:", c)

        if (r > self.rows || c > self.cols || r < 0 || c < 0) {
            return "NA"
        }
        if (r >= 1) && ( boardState[r-1][c] == empty ) {
            return "UP"
        }
        if (r <= self.rows - 2 && boardState[r+1][c] == empty) {
            return "DOWN"
        }
        if (c >= 1 && boardState[r][c-1] == empty) {
            return "LEFT"
        }
        if (c <= (self.cols - 2) && boardState[r][c+1] == empty ) {
            return "RIGHT"
        }
        return "NA"
    }
    
    func isSolved() -> Bool {
        let d = self.rows
        for i in 0 ..< (self.rows * self.cols) {
            if self.boardState[i / d][i % d] != i + 1 {
                return false
            }
        }
        return true
    }
    
    func getTile(atRow r: Int, atCol c: Int) -> Int {
        return self.boardState[r][c]
    }
    
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        if (tile > (rows*cols-1)) {
            return nil
        }
        for x in 0..<rows {
            for y in 0..<cols {
                if ((boardState[x][y]) == tile) {
                    return (row: x,column: y)
                }
            }
        }
        return nil
    }
    
    func resetBoard() {
        let d = self.rows
        
        for r in 0 ..< self.rows {
            for c in 0 ..< self.cols {
                self.boardState[r][c] = (d * r) + c + 1
            }
        }
    }
}
