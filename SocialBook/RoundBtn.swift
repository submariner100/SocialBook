//
//  RoundBtn.swift
//  SocialBook
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {

     override func awakeFromNib() {
          super.awakeFromNib()
          
          layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
          layer.shadowOpacity = 06
          layer.shadowRadius = 5.0
          layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
          imageView?.contentMode = .scaleAspectFit
          
     }
     
     override func layoutSubviews() {
          super.layoutSubviews()
          
          layer.cornerRadius = self.frame.width / 2
          
     }

}
