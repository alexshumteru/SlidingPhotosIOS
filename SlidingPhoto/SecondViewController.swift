//
//  SecondViewController.swift
//  SlidingTiles
//
//  Created by Alex Shum on 05/03/2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var iv3: UIImageView!
    
    @IBOutlet weak var iv4: UIImageView!
    @IBOutlet weak var iv2: UIImageView!
    @IBOutlet weak var iv1: UIImageView!
    var imageHandler: ImageHandler?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func easyBtn(_ sender: Any) {
        let imageArr = self.imageHandler!.splitImage(row: 3, column: 3)
        iv1.image = imageArr[0][0]
        iv2.image = imageArr[2][2]
        iv3.image = imageArr[0][2]
        iv4.image = imageArr[2][0]
        //self.performSegue(withIdentifier: "Segue2", sender: self)
    }

    @IBAction func midBtn(_ sender: Any) {
        let imageArr = self.imageHandler!.splitImage(row: 4, column: 4)
        print(imageArr[0][0], imageArr[3][3])
        //self.performSegue(withIdentifier: "Segue2", sender: self)
    }

    @IBAction func hardBtn(_ sender: Any) {
        let imageArr = self.imageHandler!.splitImage(row: 5, column: 5)
        print(imageArr[0][0], imageArr[4][4])
        //self.performSegue(withIdentifier: "Segue2", sender: self)
    }
}
