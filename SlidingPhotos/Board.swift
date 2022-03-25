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
    var moveMade : [String]
    var undoDict : [String: String]
    
    
    
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
        
        moveMade = []
        undoDict = [
            "LEFT": "RIGHT",
            "RIGHT": "LEFT",
            "UP": "DOWN",
            "DOWN": "UP"
        ]
    }
    
    func findEmpty() -> [Int]{
        for i in 0 ..< self.rows {
            for j in 0 ..< self.cols {
                if (boardState[i][j] == empty) {
                    return [i,j]
                }
            }
        }
        return [-1, -1] // Indicates something wrong with the board.
    }
    
    func canSlide(atRow r: Int, atCol c: Int) -> Bool {
        if (r > self.rows || c > self.cols || r < 0 || c < 0) {
            return false
        }
        print("r:", r)
        print("c:", c)
        return (r >= 0 && c >= 0 && r <= self.rows - 1 && c <= self.cols - 1)
                && ((r >= 1 && boardState[r-1][c] == empty) ||
               (r <= self.rows - 2 && boardState[r+1][c] == empty) ||
               (c >= 1 && boardState[r][c-1] == empty) ||
                (c <= (self.cols - 2)  && boardState[r][c+1] == empty ))
    }
    
    func scramble(numSwap n: Int) {
        // 0 - left, 1 - right, 2 - up, 3 - down
        let possibleMoves = [[-1,0], [1,0], [0,-1], [0,1]]
        var emptyTile = findEmpty()
        for _ in 1 ..< n {
            let tmp: Int = Int.random(in: 0...3)
            if canSlide(atRow: emptyTile[0] + possibleMoves[tmp][0], atCol: emptyTile[1] + possibleMoves[tmp][1]) {
                swapTiles(fromRow: emptyTile[0] + possibleMoves[tmp][0],
                          fromCol: emptyTile[1] + possibleMoves[tmp][1],
                          toRow: emptyTile[0], toCol: emptyTile[1])
                emptyTile = [emptyTile[0] + possibleMoves[tmp][0], emptyTile[1] + possibleMoves[tmp][1]]
            }
        }
    }
    
    func swapTiles(fromRow r1: Int, fromCol c1: Int, toRow r2: Int, toCol c2: Int) {
        boardState[r2][c2] = boardState[r1][c1]
        boardState[r1][c1] = empty
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
            moveMade.append("LEFT")
            swapTiles(fromRow: r, fromCol: c, toRow: r, toCol: c-1)

        }
        if (res == "RIGHT") {
            moveMade.append("RIGHT")
            swapTiles(fromRow: r, fromCol: c, toRow: r, toCol: c+1)

        }
        if (res == "UP") {
            moveMade.append("UP")
            swapTiles(fromRow: r, fromCol: c, toRow: r-1, toCol: c)
        }
        if (res == "DOWN") {
            moveMade.append("DOWN")
            swapTiles(fromRow: r, fromCol: c, toRow: r+1, toCol: c)
        }
        limitMoveMadeCount()
    }
    
    func limitMoveMadeCount() {
        if moveMade.count > 10 {
            moveMade.removeFirst()
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
    
    func getLastMove() -> String {
        if moveMade.count > 0 {
            let undoMove = moveMade.popLast()!
            return undoDict[undoMove]!
        } else {
            return "N/A"
        }
        
    }
    
    func undo(move: String) -> [Int] {
        print("pre:", boardState)

        
        let emptyTile = findEmpty()
        print(emptyTile)
        if (move == "LEFT") {
            print("1")
            swapTiles(fromRow: emptyTile[0], fromCol: emptyTile[1]+1, toRow: emptyTile[0], toCol: emptyTile[1])
        }
        
        if (move == "RIGHT") {
            print("2")
            swapTiles(fromRow: emptyTile[0], fromCol: emptyTile[1]-1, toRow: emptyTile[0], toCol: emptyTile[1])
        }
        
        if (move == "UP") {
            print("3")
            swapTiles(fromRow: emptyTile[0]+1, fromCol: emptyTile[1], toRow: emptyTile[0], toCol: emptyTile[1])
        }
        
        if (move == "DOWN") {
            swapTiles(fromRow: emptyTile[0]-1, fromCol: emptyTile[1], toRow: emptyTile[0], toCol: emptyTile[1])
        }
        print("post:", boardState)
        
        return emptyTile //emptyTile is not empty anymore, it contains the tile moved
        
    }
}
