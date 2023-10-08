//
//  String+Extension.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import UIKit

extension String {
    var asUrl: URL?{
        return URL(string: self)
    }
    
    func capitalizedFirstLetter()-> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension UIViewController {
  func screen() -> UIScreen? {
    var parent = self.parent
    var lastParent = parent
    
    while parent != nil {
      lastParent = parent
      parent = parent!.parent
    }
    
    return lastParent?.view.window?.windowScene?.screen
  }
}
