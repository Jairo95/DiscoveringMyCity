//
//  AddFavoritePlaceController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit

class AddFavoritePlaceController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var latitudField: UITextField!
    @IBOutlet weak var longitudField: UITextField!
    @IBOutlet weak var imagenView: UIImageView!
    
    let placeManager = PlaceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func photoButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true){
            //Después complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imagenView.image = image
        }
        else
        {
            print("Error imagen")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locationButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let imageData:NSData = UIImagePNGRepresentation(imagenView.image!)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        //print(strBase64)

        placeManager.addFavoritePlace(name: nameField.text!, latitud: Double(latitudField.text!), longitud: Double(longitudField.text!), categoria: categoryField.text!, imagen: strBase64)
    }
    
}
