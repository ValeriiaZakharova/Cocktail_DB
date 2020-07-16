//
//  Font.swift
//  Cocktail_DB
//
//  Created by Valeriia Zakharova on 14.07.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

extension UIFont {
  
  static func Regular(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Regular", size: size) ?? systemFont(ofSize: size)
  }
}
