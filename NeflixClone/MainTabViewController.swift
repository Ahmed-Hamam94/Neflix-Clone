//
//  ViewController.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 01/10/2023.
//

import UIKit

class MainTAbViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureTabBAr()
    }

// MARK: - Private Functions
    
    private func ConfigureTabBAr() {
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcominViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        // add image
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        // add title
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }
}

