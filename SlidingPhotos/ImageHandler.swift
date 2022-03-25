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

extension UIImage {
    func resizeImage(targetHeight: CGFloat, targetWidth: CGFloat) -> UIImage {
        // Get current image size
        let size = self.size

        // Compute scaled, new size
        let heightRatio = targetHeight / size.height
        let widthRatio = targetWidth / size.width
        let newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Create new image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Return new image
        return newImage!
    }
}
