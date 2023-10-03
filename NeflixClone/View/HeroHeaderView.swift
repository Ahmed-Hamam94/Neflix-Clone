//
//  HeroHeaderView.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let imageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "posterHeader")
        return image
    }()
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButoon: UIButton = {
        let button = UIButton()
         button.setTitle("Download", for: .normal)
         button.layer.borderColor = UIColor.white.cgColor
         button.layer.borderWidth = 1
         button.layer.cornerRadius = 5
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButoon)
        applyConstraintsToPlayButton()
        applyConstraintsToDownloadButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        
    }
    
    private func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    private func applyConstraintsToPlayButton(){
        
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)

    }
    private func applyConstraintsToDownloadButton(){
        
        let DownloadButtonConstraints = [
            downloadButoon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButoon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButoon.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(DownloadButtonConstraints)

    }
    
}
