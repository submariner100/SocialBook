//
//  PostCell.swift
//  SocialBook
//
//  Created by Macbook on 08/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

     @IBOutlet weak var profileImg: UIImageView!
     @IBOutlet weak var usernameLbl: UILabel!
     @IBOutlet weak var postImg: UIImageView!
     @IBOutlet weak var captionTxt: UITextView!
     @IBOutlet weak var likesLbl: UILabel!


     var post: Post!
     
     
     override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
     }
     
     func configureCell(post: Post) {
          self.post = post
          self.captionTxt.text = post.caption
          self.likesLbl.text = "\(post.likes)"
          
     }

     
     
     


     
    }
