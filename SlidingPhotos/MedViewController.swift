//
//  MedViewController.swift
//  SlidingPhoto
//
//  Created by Alex Shum on 06/03/2022.
//

import UIKit
import AVFoundation

class MedViewController: UIViewController {

    var images: [[UIImage]]?
    var audio: AVAudioPlayer?
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var toHomePage: UIButton!
    @IBOutlet weak var undo: UIButton!

    
    @IBAction func toHome(_ sender: Any) {
        self.performSegue(withIdentifier: "toHomeMed", sender: self)
    }
    
    @IBAction func tileSelected(_ sender: UIButton) {
        let pathToSound = Bundle.main.path(forResource: "Pop-sound-effect", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            audio = try AVAudioPlayer(contentsOf: url)
            audio!.play()
        } catch{
            print(error)
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.midBoard
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
                    self.boardView.addLastTile()
                    self.showWonPopUp()
                }
                
                UIView.animate(withDuration: 0.5, delay: 0.45, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.view.window!.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
                }, completion: nil)
            }
        } // end if slide
    }
    
    @IBAction func executeUndo(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.midBoard
        let move = board!.getLastMove()
        
        if move == "N/A" {
            noMoreUndoPopUp()
            return
        }
        print("test move:", move)
        let pathToSound = Bundle.main.path(forResource: "Reverse-pop", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            audio = try AVAudioPlayer(contentsOf: url)
            audio!.play()
        } catch{
            print(error)
        }
        let pos = board!.undo(move: move)
        let tag = board!.boardState[pos[0]][pos[1]]
        let sender = boardView.viewWithTag(tag) as! UIButton
        let buttonBounds = sender.bounds
        var buttonCenter = sender.center

        if move == "UP" {
            buttonCenter.y -= buttonBounds.size.height
        } else if move == "DOWN" {
            buttonCenter.y += buttonBounds.size.height
        } else if move == "LEFT" {
            buttonCenter.x -= buttonBounds.size.width
        } else if move == "RIGHT" {
            buttonCenter.x += buttonBounds.size.width
        }

        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {sender.center = buttonCenter})
        
    }
    
    
    func showWonPopUp(){
        let alert = UIAlertController(title: "Congrats", message: "You Won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to homepage", style: .default,
                                      handler: {action in self.performSegue(withIdentifier: "toHomeMed", sender: self)}))
        present(alert, animated: true)
    }
    
    
    
    func noMoreUndoPopUp() {
        let alert = UIAlertController(title: "No more undos left", message: "No more undos left", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView.center = CGPoint(x: self.view.frame.size.width/2,
                                   y: self.view.frame.size.height/2)
        toHomePage.center = CGPoint(x: (self.view.frame.size.width)*(2/3),
                                    y: self.view.frame.size.height/10)
        undo.center = CGPoint(x: self.view.frame.size.width/4,
                              y: self.view.frame.size.height/10)
        boardView.passInImages(images: self.images!)
        let minDim = [UIScreen.main.bounds.width, UIScreen.main.bounds.height].min();
        boardView.passInMinDim(minDim: minDim);
        //print(images!.count, images![0].count)
        // Do any additional setup after loading the view.
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
             return .portrait
     }
}
