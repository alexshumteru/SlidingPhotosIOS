//
//  BoardView.swift
//  SlidingPhoto
//
//  Created by John Park on 2022-03-16.
//

import UIKit

class BoardView: UIView {

    var images: [[UIImage]]?
    var dimension: Int?
    var board: Board?
    var tileSize: CGFloat?
    var minDim: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func passInImages(images: [[UIImage]]){
        self.images = images
    }
    
    func passInMinDim(minDim: CGFloat){
        self.minDim = minDim;
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
        var boardSquare: CGRect?
        // determine region to hold tiles (see below)
        if (self.tag == 103) {
            boardSquare = boardRect(dimInt: 3, dimFloat: 3.0)
            self.board = appDelegate.easyBoard
            self.tileSize = (boardSquare!.width) / 3.0
            self.dimension = 3

        }
        else if (self.tag == 104) {
            boardSquare = boardRect(dimInt: 4, dimFloat: 4.0)
            self.board = appDelegate.midBoard
            self.tileSize = (boardSquare!.width) / 4.0
            self.dimension = 4
        }
        else if (self.tag == 105) {
            boardSquare = boardRect(dimInt: 5, dimFloat: 5.0)
            self.board = appDelegate.hardBoard
            self.tileSize = (boardSquare!.width) / 5.0
            self.dimension = 5

        }
        
        let tileBounds = CGRect(x: 0, y: 0, width: self.tileSize!, height: self.tileSize!)
        
        for r in 0 ..< self.dimension! {
            for c in 0 ..< self.dimension! {
                
                let tile = board!.getTile(atRow: r, atCol: c)
                if tile != (self.dimension! * self.dimension!) {
                    let button = self.viewWithTag(tile) as! UIButton
                    //button.setTitle(String(tile), for: UIControl.State.normal)
                    button.setTitle("", for: UIControl.State.normal)
                    button.bounds = tileBounds
                    button.center = CGPoint(x: (CGFloat(c) + 0.5) * self.tileSize!,
                                            y: (CGFloat(r) + 0.5) * self.tileSize!)
                    let x = (tile - 1) % self.dimension!
                    let y = (tile - 1) / self.dimension!
                    print(images!.count, images![0].count)
                    if (self.tag == 103){
                        button.setImage(images![y][x].resizeImage(targetHeight: self.minDim! * 0.327, targetWidth: self.minDim! * 0.327), for: [])
                    } else if (self.tag == 104){
                        button.setImage(images![y][x].resizeImage(targetHeight: self.minDim! * 0.246, targetWidth: self.minDim! * 0.246), for: [])
                    } else if (self.tag == 105){
                        button.setImage(images![y][x].resizeImage(targetHeight: self.minDim! * 0.195, targetWidth: self.minDim! * 0.195), for: [])
                    }
                }
            }
        }
    }
    
    func addLastTile() {
//        var lastTile = images![self.dimension!-1][self.dimension!-1]
//        if (self.tag == 103){
//            lastTile = lastTile.resizeImage(targetHeight: 128.0, targetWidth: 128.0)
//        } else if (self.tag == 104){
//            lastTile = lastTile.resizeImage(targetHeight: 96.0, targetWidth: 96.0)
//        } else if (self.tag == 105){
//            lastTile = lastTile.resizeImage(targetHeight: 76.0, targetWidth: 76.0)
//        }
//        let imageView = UIImageView(image: lastTile)
//        imageView.frame = CGRect(x: 0, y: 0, width: tileSize!, height: tileSize!)
//        imageView.center = CGPoint(x: (CGFloat(self.dimension! - 1) + 0.5) * self.tileSize!,
//                                   y: (CGFloat(self.dimension! - 1) + 0.5) * self.tileSize!)
//        super.addSubview(imageView)
//        super.bringSubviewToFront(imageView)
        let lastTile = UIButton()
        lastTile.setTitle("", for: UIControl.State.normal)
        let tileBounds = CGRect(x: 0, y: 0, width: tileSize!, height: tileSize!)
        lastTile.bounds = tileBounds
        lastTile.center = CGPoint(x: (CGFloat(self.dimension! - 1) + 0.5) * self.tileSize!,
                                  y: (CGFloat(self.dimension! - 1) + 0.5) * self.tileSize!)
        if (self.tag == 103){
            lastTile.setImage(images![2][2].resizeImage(targetHeight: self.minDim! * 0.328, targetWidth: self.minDim! * 0.328), for: [])
        } else if (self.tag == 104){
            lastTile.setImage(images![3][3].resizeImage(targetHeight: self.minDim! * 0.247, targetWidth: self.minDim! * 0.247), for: [])
        } else if (self.tag == 105){
            lastTile.setImage(images![4][4].resizeImage(targetHeight: self.minDim! * 0.196, targetWidth: self.minDim! * 0.196), for: [])
        }
        super.addSubview(lastTile)
    }
    
}


