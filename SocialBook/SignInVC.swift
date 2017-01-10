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
import FBSDKLoginKit
import SwiftKeychainWrapper


class SignInVC: UIViewController {
     
     @IBOutlet weak var emailField: TextField!
     @IBOutlet weak var pwdField: TextField!
     
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
     }
     
     override func viewDidAppear(_ animated: Bool) {
     
          if KeychainWrapper.standard.string(forKey: KEY_UID) != nil {
         
          print("Mike - ID found in keychain")
               
          performSegue(withIdentifier: "goToFeedVC", sender: nil)
               
          }
          

     }
     
     @IBAction func facebookBtnTapped(_ sender: Any) {
          
          let facebookLogin = FBSDKLoginManager()
          
          facebookLogin.logIn(withReadPermissions: ["email"], from: self) { ( result, error ) in
               
               if error != nil {
                    print("Mike: Unable to auth with Facebook - \(error)")
                    
               } else if result?.isCancelled == true {
                    
                    print("Mike - user cancelled Facebook auth")
                    
               } else {
                    
                    print("Mike - Successfully authenicated with Facebook")
                    
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
                    print("Mike - Successfully authenicated with Firebase")
                    
                    if let user = user {
                    let userData = ["provider": credential.provider]
                    
                    
                    self.completeSignIn(id: user.uid, userData: userData)
                    
                    
                    }
                    
               }
          })
     }
          @IBAction func signInTapped(_ sender: Any) {
          
               if let email = emailField.text, let pwd = pwdField.text {
                    FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                    
                         if error == nil {
                         
                              print("Mike: Email user authenicated with Firebase")
                              
                              if let user = user {
                              let userData = ["provider": user.providerID]
                              self.completeSignIn(id: user.uid, userData: userData)
                              }
                              
                         } else {
                         
                              FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                                   if error != nil {
                                   print("Mike: Unable to anthenicate with Firebase using email")
                              } else {
                                        
                                   print("Mike: Successfully authenicate with Firebase")
                                   if let user = user {
                                   let userData = ["provider": user.providerID]
                                   self.completeSignIn(id: user.uid, userData: userData)
                                   }
                                   }
                              })
                                   
                              }
                         })
               
                    }
          
                  }
     
          func completeSignIn(id: String, userData: Dictionary<String, String>) {
          
               DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
          
               let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
               //let keychainResult = KeychainWrapper.standard.string(forKey: KEY_UID)
               print("Mike: Data saved to keychain \(keychainResult)")
               performSegue(withIdentifier: "goToFeedVC", sender: nil)
     }
  
}

// Colors : #673AB7 #4527A0 415CA4
