//
//  SearchResultsViewController.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 05/10/2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    
    func searchResultsViewControllerDidTap(model: MoviePreview)
}


class SearchResultsViewController: UIViewController {
    
     let searchResultCollectionView: UICollectionView = {
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let width = window?.screen.bounds.width ?? 0
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
       return collectionView
    }()
  
     var searchMovies: [Movie] = [Movie]()
    weak var searchResultDelegate: SearchResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
    private func setUpUI(){
       
    }

    private func configureCollectionView(){
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
  

}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
         let movie = searchMovies[indexPath.row]
        cell.configure(with: movie.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = searchMovies[indexPath.row]
        guard let movieTitle = movie.originalTitle ?? movie.originalName else {return}
        guard let titleOverview = searchMovies[indexPath.row].overview else {return}
                    
        YoutubeSearch.get_YoutubeSearch(query: movieTitle + " trailer") { [weak self] result in
            guard let self else {return}
                  switch result {
                  case .success(let videoElement):
                    
                     let moviePreview = MoviePreview(title: movieTitle, titleOverview: titleOverview, youtubeView: videoElement)
                      
                      self.searchResultDelegate?.searchResultsViewControllerDidTap(model: moviePreview)
                      
                  case .failure(let error):
                      print(error.localizedDescription)
                  }
              }
    
    }
    
    
}
