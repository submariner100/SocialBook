//
//  CircleView.swift
//  SocialBook
//
//  Created by Macbook on 08/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit

class CircleView: UIImageView {


     override func layoutSubviews() {
     
          layer.cornerRadius = self.frame.width / 2
     }
}



     

  
