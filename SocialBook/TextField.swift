//
//  TextField.swift
//  SocialBook
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit

class TextField: UITextField {

     override func awakeFromNib() {
          super.awakeFromNib()
          
          layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
          layer.borderWidth = 1.0
          layer.cornerRadius = 3.0
          
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.insetBy(dx: 10, dy: 5)
          
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.insetBy(dx: 10, dy: 5)
     }
}
