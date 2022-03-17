//
//  MedViewController.swift
//  SlidingPhoto
//
//  Created by Alex Shum on 06/03/2022.
//

import UIKit

class MedViewController: UIViewController {

    var images: [[UIImage]]?
    
    @IBOutlet weak var boardView: BoardView!
    
    @IBAction func tileSelected(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
        boardView.test()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(images!.count, images![0].count)
        // Do any additional setup after loading the view.
        
    }
    

}
