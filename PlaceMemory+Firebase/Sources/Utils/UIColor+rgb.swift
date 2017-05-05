//
//  UIColor+rgb.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
}
