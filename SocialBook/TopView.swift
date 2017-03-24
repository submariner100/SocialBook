//
//  TopView.swift
//  SocialBook
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit

class TopView: UIView {

     override func awakeFromNib() {
          super.awakeFromNib()
          
          layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
          layer.shadowOpacity = 04
          layer.shadowRadius = 5.0
          layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
          layer.cornerRadius = 2.0
     }
      
}
