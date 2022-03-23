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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func passInImages(images: [[UIImage]]){
        self.images = images
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
        var tileSize: CGFloat?
        var boardSquare: CGRect?
        // determine region to hold tiles (see below)
        if (self.tag == 103) {
            boardSquare = boardRect(dimInt: 3, dimFloat: 3.0)
            self.board = appDelegate.easyBoard
            tileSize = (boardSquare!.width) / 3.0
            self.dimension = 3

        }
        else if (self.tag == 104) {
            boardSquare = boardRect(dimInt: 4, dimFloat: 4.0)
            self.board = appDelegate.midBoard
            tileSize = (boardSquare!.width) / 4.0
            self.dimension = 4
        }
        else if (self.tag == 105) {
            boardSquare = boardRect(dimInt: 5, dimFloat: 5.0)
            self.board = appDelegate.hardBoard
            tileSize = (boardSquare!.width) / 5.0
            self.dimension = 5

        }
        
        let tileBounds = CGRect(x: 0, y: 0, width: tileSize!, height: tileSize!)
        
        for r in 0 ..< self.dimension! {
            for c in 0 ..< self.dimension! {
                
                let tile = board!.getTile(atRow: r, atCol: c)
                if tile != (self.dimension! * self.dimension!) {
                    let button = self.viewWithTag(tile) as! UIButton
                    button.setTitle(String(""), for: UIControl.State.normal)
                    button.bounds = tileBounds
                    button.center = CGPoint(x: (CGFloat(c) + 0.5) * tileSize!,
                                            y: (CGFloat(r) + 0.5) * tileSize!)
                    let x = (tile - 1) % self.dimension!
                    let y = (tile - 1) / self.dimension!
                    print(images!.count, images![0].count)
                    if (self.tag == 103){
                        button.setImage(self.resizeImage(image: images![y][x], targetHeight: 128.0, targetWidth: 128.0), for: [])
                    } else if (self.tag == 104){
                        button.setImage(self.resizeImage(image: images![y][x], targetHeight: 96.0, targetWidth: 96.0), for: [])
                    } else if (self.tag == 105){
                        button.setImage(self.resizeImage(image: images![y][x], targetHeight: 76.0, targetWidth: 76.0), for: [])
                    }
                }
            }
        }
    }
    
    fileprivate func resizeImage(image: UIImage, targetHeight: CGFloat, targetWidth: CGFloat) -> UIImage {
        // Get current image size
        let size = image.size

        // Compute scaled, new size
        let heightRatio = targetHeight / size.height
        let widthRatio = targetWidth / size.width
        let newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Create new image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Return new image
        return newImage!
    }
    
}
