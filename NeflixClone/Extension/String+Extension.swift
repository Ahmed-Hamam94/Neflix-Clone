//
//  String+Extension.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

extension String {
    var asUrl: URL?{
        return URL(string: self)
    }
    
    func capitalizedFirstLetter()-> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
