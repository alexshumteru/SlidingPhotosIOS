//
//  ImageHandler.swift
//  SlidingTiles
//
//  Created by Alex Shum on 05/03/2022.
//

import Foundation
import UIKit

class ImageHandler: NSObject  {

    var image: UIImage
    
    init?(userImage : UIImage) {
        self.image = userImage
    }

    func splitImage(row : Int , column : Int) -> [[UIImage]]{
        let oImg = self.image
        let height =  (self.image.size.height) /  CGFloat (row)
        let width =  (self.image.size.width)  / CGFloat (column)
        let scale = (self.image.scale)

        var imageArr = [[UIImage]]()
        for y in 0..<row{
            var yArr = [UIImage]()
            for x in 0..<column{
                UIGraphicsBeginImageContextWithOptions(
                    CGSize(width:width, height:height),
                    false, 0)
                let i =  oImg.cgImage?.cropping(to:  CGRect.init(x: CGFloat(x) * width * scale, y:  CGFloat(y) * height * scale  , width: CGFloat((width * scale)) , height: CGFloat((height * scale))) )

                let newImg = UIImage.init(cgImage: i!)

                yArr.append(newImg)

                UIGraphicsEndImageContext();
            }
            imageArr.append(yArr)
        }
        return imageArr

    }

}
