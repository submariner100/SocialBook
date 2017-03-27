//
//  PostCell.swift
//  SocialBook
//
//  Created by Macbook on 08/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

     @IBOutlet weak var profileImg: UIImageView!
     @IBOutlet weak var usernameLbl: UILabel!
     @IBOutlet weak var postImg: UIImageView!
     @IBOutlet weak var captionTxt: UITextView!
     @IBOutlet weak var likes: UILabel!
     @IBOutlet weak var likeImg: UIImageView!
     
     
     var post: Post!
     var likesRef: FIRDatabaseReference!

     
     
     override func awakeFromNib() {
          super.awakeFromNib()
          
          let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
          tap.numberOfTapsRequired = 1
          likeImg.addGestureRecognizer(tap)
          likeImg.isUserInteractionEnabled = true
     }
     
     func configureCell(post: Post, img: UIImage? = nil) {
          self.post = post
          likesRef = DataService.ds.REF_USER_CURRENT.child("like").child(post.postKey)
          
          self.captionTxt.text = post.caption
          self.likes.text = "\(post.likes)"
          
          if img != nil {
               self.postImg.image = img
               } else {
               let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
               ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error ) in
                    if error != nil {
                         print("Mike: Unable to download image from Firebase storage")
                    } else {
                         print("Mike: Image downloaded from Firebase storage")
                         if let imgData = data {
                              if let img = UIImage(data: imgData) {
                                   self.postImg.image = img
                                   FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                                   
                              }
                            }
                         }
                   })
               }
          
               likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
               if let _ = snapshot.value as? NSNull {
                    self.likeImg.image = UIImage(named: "filled-heart")
                    
                    } else {
                    
                    self.likeImg.image = UIImage(named: "empty-heart")
                    
                    }
               
          })
}
     
           func likeTapped(sender: UITapGestureRecognizer) {
                    likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let _ = snapshot.value as? NSNull {
                         self.likeImg.image = UIImage(named: "empty-heart")
                         self.post.adjustLikes(addLike: true)
                         self.likesRef.setValue(true)
                    } else {
                         
                         self.likeImg.image = UIImage(named: "filled-heart")
                         self.post.adjustLikes(addLike: false)
                         self.likesRef.removeValue()
                         }
                         
          })
     }
     
}


