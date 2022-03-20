//
//  EasyViewController.swift
//  SlidingPhoto
//
//  Created by Alex Shum on 06/03/2022.
//

import UIKit

class EasyViewController: UIViewController {

    var images: [[UIImage]]?
    
    @IBOutlet weak var boardView: BoardView!
    
    @IBAction func tileSelected(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.easyBoard
        let pos = board!.getRowAndColumn(forTile: sender.tag)
        let buttonBounds = sender.bounds
        var buttonCenter = sender.center
        var slide = true
        let resPos = board!.possibleSlidePosition(atRow: pos!.row, atCol: pos!.column)
        if resPos == "UP" {
            buttonCenter.y -= buttonBounds.size.height
        } else if resPos == "DOWN" {
            buttonCenter.y += buttonBounds.size.height
        } else if resPos == "LEFT" {
            buttonCenter.x -= buttonBounds.size.width
        } else if resPos == "RIGHT" {
            buttonCenter.x += buttonBounds.size.width
        } else {
            slide = false
        }
        if slide {
            board!.slideTile(atRow: pos!.row, atCol: pos!.column)
            // sender.center = buttonCenter // or animate the change
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {sender.center = buttonCenter})
            if (board!.isSolved()) {
                UIView.animate(withDuration: 0.5) { () -> Void in
                    self.view.window!.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }
                
                UIView.animate(withDuration: 0.5, delay: 0.45, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.view.window!.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
                }, completion: nil)
            }
        } // end if slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(images!.count, images![0].count)
        
        // Do any additional setup after loading the view.
    }
    
}
