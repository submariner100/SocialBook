//
//  FeedVC.swift
//  SocialBook
//
//  Created by Macbook on 07/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

   
   
   
     @IBAction func signInTapped(_ sender: Any) {
          
          let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
          
          print("Mike - ID removed from keychain \(keychainResult)")
          
          try! FIRAuth.auth()?.signOut()
          
          performSegue(withIdentifier: "goToSignInVC", sender: nil)
          
          
     }
}
