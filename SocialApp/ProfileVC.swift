//
//  ProfileVC.swift
//  SocialApp
//
//  Created by VLADISLAV TAIURSKIY on 22.06.16.
//  Copyright © 2016 Vladislav Taiurskiy. All rights reserved.
//

import UIKit

import FirebaseAuth

class ProfileVC: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let currentUser = UserDefaults.standard().value(forKey: "username")
        usernameLabel.text = "Hello! \(currentUser!)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout() {
        try! FIRAuth.auth()?.signOut()
        
        // clean NSUserDefaults
        
        UserDefaults.standard().setValue(nil, forKey: "uid")
        UserDefaults.standard().setValue(nil, forKey: "username")
        
        
        segoeToGuest()
    }
    
    
    func segoeToGuest() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "Start") as! StartScreenVC
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    
}
