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


     var post: Post!
     
     
     override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
     }
     
     func configureCell(post: Post, img: UIImage? = nil) {
          self.post = post
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
           }
     }

