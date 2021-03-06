//
//  SecondViewController.swift
//  SlidingTiles
//
//  Created by Alex Shum on 05/03/2022.
//

import UIKit

class SecondViewController: UIViewController {

    var imageHandler: ImageHandler?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func easyBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "ToEasy", sender: self)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.easyBoard
        board!.scramble(numSwap: 200)
        board!.moveMade.removeAll()
    }

    @IBAction func midBtn(_ sender: Any) {
        //print(imageArr[0][0], imageArr[3][3])
        self.performSegue(withIdentifier: "ToMed", sender: self)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.midBoard
        board!.scramble(numSwap: 200)
        board!.moveMade.removeAll()
    }

    @IBAction func hardBtn(_ sender: Any) {
        
        //print(imageArr[0][0], imageArr[4][4])
        self.performSegue(withIdentifier: "ToHard", sender: self)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.hardBoard
        board!.scramble(numSwap: 200)
        board!.moveMade.removeAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEasy"{
            let destinationVC = segue.destination as! EasyViewController
            let splitImages = self.imageHandler!.splitImage(row: 3, column: 3)
            destinationVC.images = splitImages
        } else if segue.identifier == "ToMed"{
            let destinationVC = segue.destination as! MedViewController
            let splitImages = self.imageHandler!.splitImage(row: 4, column: 4)
            destinationVC.images = splitImages
        } else if segue.identifier == "ToHard"{
            let destinationVC = segue.destination as! HardViewController
            let splitImages = self.imageHandler!.splitImage(row: 5, column: 5)
            destinationVC.images = splitImages
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
             return .portrait
     }
}
