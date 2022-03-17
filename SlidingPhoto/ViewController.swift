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
    
    var imageHandler: ImageHandler!
    
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SecondViewController
        destinationVC.imageHandler = self.imageHandler
    }
    
    @IBAction func confirmPhoto(_ sender: Any) {
        if imageView.image != nil{
            var image: UIImage
            image = imageView.image!
            self.imageHandler = ImageHandler(userImage: image)!
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

