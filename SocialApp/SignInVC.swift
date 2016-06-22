//
//  SignIn.swift
//  SocialApp
//
//  Created by VLADISLAV TAIURSKIY on 22.06.16.
//  Copyright © 2016 Vladislav Taiurskiy. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    var firebaseRef: FIRDatabaseReference = FIRDatabase.database().reference()
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.94, alpha: 1)
        spinnerView.isHidden = true
        spinnerView.stopAnimating()
        
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        signInButton.isEnabled = false
        spinnerView.isHidden = false
        spinnerView.startAnimating()
        self.view.alpha = 0.5
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if (email != "" && password != "") {
            
            FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
                
                if error != nil {
                    self.signInButton.isEnabled = true
                    self.spinnerView.isHidden = true
                    self.spinnerView.stopAnimating()
                    self.view.alpha = 1
                    self.presentAlert(error!.localizedDescription)
                } else {
                    // no errors
                    
                    let userRef = self.firebaseRef.child("users/\(user!.uid)")
                    userRef.observeSingleEvent(of: .value, with: { snapshot in
                        
                        let username = snapshot.value?.object(forKey: "username") as? String
                        
                        UserDefaults.standard().setValue(user?.uid, forKey: "uid")
                        UserDefaults.standard().setValue(username, forKey: "username")
                        
                        self.segoeToHomeVC()
                        
                        }, withCancel: { error in
                            print(error.description)
                            
                    })
                }
            })
        } else {
            // if empty fields
            self.presentAlert("Enter email and password")
            self.spinnerView.isHidden = true
            self.spinnerView.stopAnimating()
            self.view.alpha = 1
            self.signInButton.isEnabled = true
        }
        
        
        
    }
    
    func segoeToHomeVC() {
        self.view.window?.alpha = 1
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeVC
        present(controller, animated: true, completion: nil)
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
