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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

     @IBOutlet weak var tableView: UITableView!
     
     @IBOutlet weak var imageAdd: CircleView!
     var posts = [Post]()
     var imagePicker: UIImagePickerController!

     override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
          if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
              for snap in snapshot {
               print("SNAP: \(snap)")
               if let postDict = snap.value as? Dictionary<String, AnyObject> {
                    let key = snap.key
                    let post = Post(postKey: key, postData: postDict)
                    self.posts.append(post)
                    
                    
               }
               
               }
          }
          self.tableView.reloadData()
          
          })
     
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
          return 1
     }
     
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return posts.count
          
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let post = posts[indexPath.row]
          
          if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
          cell.configureCell(post: post)
          return cell
          } else {
          return PostCell()
          }
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     
          imagePicker.dismiss(animated: true, completion: nil)
          if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
               imageAdd.image = image
          } else {
          
               print("MIKE: A valid image wasn't selected")
          }
               imagePicker.dismiss(animated: true, completion: nil)
     
     }
     
     
     @IBAction func addImageTapped(_ sender: Any) {
          present(imagePicker, animated: true, completion: nil)
     
     }
   
     @IBAction func signOutTapped(_ sender: Any) {
          
          let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
          print("Mike - ID removed from keychain \(keychainResult)")
          try! FIRAuth.auth()?.signOut()
          performSegue(withIdentifier: "goToSignInVC", sender: nil)
          
          
     }
}
