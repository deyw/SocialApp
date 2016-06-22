//
//  SignUpVC.swift
//  SocialApp
//
//  Created by VLADISLAV TAIURSKIY on 22.06.16.
//  Copyright © 2016 Vladislav Taiurskiy. All rights reserved.
//

import UIKit
import Firebase


class SignUpVC: UIViewController {
    
    
    let firebaseRef: FIRDatabaseReference  = FIRDatabase.database().reference()
    var base64String: String?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.94, alpha: 1)
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    @IBAction func create(_ sender: UIButton) {
        
        spinner.startAnimating()
        spinner.isHidden = false
        
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (username != "" && email != "" && password != "") {
            
            FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user, error) in
                
                if error != nil {
                    self.presentAlert(error!.localizedDescription)
                } else {
                    
                    FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
                        
                        if error != nil {
                            self.presentAlert("Error Auth User!")
                        } else {
                            
                            // user default avatar
                            let image = UIImage(named: "default_userpic.png")
                            let imageData: Data = UIImagePNGRepresentation(image!)!
                            self.base64String = imageData.base64EncodedString(.encoding64CharacterLineLength)
                            
                            let userData: [String: AnyObject]  = [
                                "email": email!,
                                "username": username!,
                                "profileImage": self.base64String!
                            ]
                            
                            self.firebaseRef.child("users").child(user!.uid).setValue(userData)
                            
                            UserDefaults.standard().setValue(user!.uid, forKey: "uid")
                            UserDefaults.standard().setValue(username, forKey: "username")
                            
                            self.segoeToHomeScreen()
                            
                        }
                        
                    })
                }
            })
            
        } else {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.presentAlert("Please fill all fields!")
        }
    }
    
    func segoeToHomeScreen() {
        self.view.window?.alpha = 1
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeVC
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func presentAlert(_ type: String) {
        let alertController = UIAlertController()
        alertController.message = type
        
        let alertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel){
            action in
            
        }
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
