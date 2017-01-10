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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

     @IBOutlet weak var tableView: UITableView!
     

     override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
     
     
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
          return 1
     }
     
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
          return 3
          
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
          return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
     }

   
     @IBAction func signOutTapped(_ sender: Any) {
          
          let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
          print("Mike - ID removed from keychain \(keychainResult)")
          try! FIRAuth.auth()?.signOut()
          performSegue(withIdentifier: "goToSignInVC", sender: nil)
          
          
     }
}
