//
//  BoardView.swift
//  SlidingPhoto
//
//  Created by John Park on 2022-03-16.
//

import UIKit

class BoardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func boardRect(dimInt : Int, dimFloat : CGFloat) -> CGRect { // get square for holding 4x4 tiles buttons
        let W = self.bounds.size.width
        let H = self.bounds.size.height
        
        let m = 2 * dimInt
        let n = 2.0 * dimFloat
        let e = (2 * dimInt) - 1
        
        let margin : CGFloat = 0
        let size = ((W <= H) ? W : H) - margin // makes this CGFloat
        let boardSize : CGFloat = CGFloat((Int(size) + e)/m)*n // next multiple of 8
        let leftMargin = (W - boardSize)/2
        let topMargin = (H - boardSize)/2
        return CGRect(x: leftMargin, y: topMargin, width: boardSize, height: boardSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        var board: Board?
        var tileSize: CGFloat?
        var boardSquare: CGRect?
        // determine region to hold tiles (see below)
        if (self.tag == 103) {
            boardSquare = boardRect(dimInt: 3, dimFloat: 3.0)
            board = appDelegate.easyBoard
            tileSize = (boardSquare!.width) / 3.0

        }
        else if (self.tag == 104) {
            boardSquare = boardRect(dimInt: 4, dimFloat: 4.0)
            board = appDelegate.midBoard
            tileSize = (boardSquare!.width) / 4.0
        }
        else if (self.tag == 105) {
            boardSquare = boardRect(dimInt: 5, dimFloat: 5.0)
            board = appDelegate.hardBoard
            tileSize = (boardSquare!.width) / 5.0

        }
        let tileBounds = CGRect(x: 0, y: 0, width: tileSize!, height: tileSize!)
        
        for r in 0 ..< 4 {
            for c in 0 ..< 4 {
                
                let tile = board!.getTile(atRow: r, atCol: c)
                if tile != 16 {
                    let button = self.viewWithTag(tile) as! UIButton
                    button.setTitle(String(tile), for: UIControl.State.normal)
                    button.bounds = tileBounds
                    button.center = CGPoint(x: (CGFloat(c) + 0.5) * tileSize!,
                                            y: (CGFloat(r) + 0.5) * tileSize!)
                }
            }
        }
    }
    
}
