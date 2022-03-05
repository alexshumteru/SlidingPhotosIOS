//
//  ViewController.swift
//  SlidingTiles
//
//  Created by Alex Shum on 05/03/2022.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    //var image: UIImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func pickPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        var image: UIImage
        var imageHandler : ImageHandler
        var fourByFour : [[UIImage]]
        if imageView.image != nil{
            image = imageView.image!
            imageHandler = ImageHandler(userImage: image)!
            fourByFour = imageHandler.splitImage(row: 4, column: 4)
            print(image)
            print(fourByFour[0][0])
            print(fourByFour[3][3])
        }
    }
    
    
    @IBAction func confirmPhoto(_ sender: Any) {
        if imageView.image != nil{
            self.performSegue(withIdentifier: "Segue1", sender: self)
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            imageView.image = image

            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

