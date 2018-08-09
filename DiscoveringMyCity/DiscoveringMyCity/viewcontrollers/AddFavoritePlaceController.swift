//
//  AddFavoritePlaceController.swift
//  DiscoveringMyCity
//
//  Created by JAIRO PROAÑO on 19/7/18.
//  Copyright © 2018 Optativa Profesional. All rights reserved.
//

import UIKit
import GoogleMaps

class AddFavoritePlaceController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var latitudField: UITextField!
    @IBOutlet weak var longitudField: UITextField!
    @IBOutlet weak var imagenView: UIImageView!
    var myPosition: Place!
    var locationManager = CLLocationManager()
    
    let placeManager = PlaceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocation()
    }
    
    func initLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
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
        latitudField.text = "\(self.myPosition.latitude)"
        longitudField.text = "\(self.myPosition.longitude)"
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        self.myPosition = Place()
        self.myPosition.latitude = location.latitude
        self.myPosition.longitude = location.longitude
        
        print("[MY POSITION]: \(myPosition)")
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let imageData:NSData = UIImagePNGRepresentation(imagenView.image!)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        //print(strBase64)

        placeManager.addFavoritePlace(name: nameField.text!, latitud: Double(latitudField.text!), longitud: Double(longitudField.text!), categoria: categoryField.text!, imagen: strBase64)
    }
    
}
