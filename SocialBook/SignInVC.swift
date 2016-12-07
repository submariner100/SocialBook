//
//  SignInVC.swift
//  SocialBook
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {

     override func viewDidLoad() {
          super.viewDidLoad()
               
     }

     @IBAction func facebookBtnTapped(_ sender: Any) {
     
          let facebookLogin = FBSDKLoginManager()
          facebookLogin.logIn(withReadPermissions: ["email"], from: self) { ( result, error ) in
          
               if error != nil {
                    print("Mike: Unable to auth with Facebook - \(error)")
                    
               } else if result?.isCancelled == true {
                    
                    print("Mike - user cancelled Facebook auth")
                    
               } else {
                    
                    print("Mike - Successfully auth with Facebook")
                    
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    self.firebaseAuth(credential)
               }
          }
          
     }
     
     func firebaseAuth(_ credential: FIRAuthCredential) {
               FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                    if error != nil {
                         print("Mike - unable to authenicate with Firebase - \(error)")
                         
                    } else {
                         print("Mike - Successfully authernicated with Firebase")
                    }
               })
           }
     }

// Colors : #673AB7 #4527A0 415CA4
