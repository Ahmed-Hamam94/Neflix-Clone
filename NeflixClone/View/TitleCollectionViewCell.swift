//
//  TitleCollectionViewCell.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 04/10/2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with model: String){
        guard let url = "https://image.tmdb.org/t/p/w500\(model)".asUrl else {return}
        posterImageView.sd_setImage(with: url)
        print(model)
    }
}
