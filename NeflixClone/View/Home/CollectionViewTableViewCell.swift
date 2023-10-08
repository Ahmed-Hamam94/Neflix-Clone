//
//  CollectionViewTableViewCell.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    
    func collectionViewTableViewCellDidTap(_ cell:  CollectionViewTableViewCell, model: MoviePreview)
}

class CollectionViewTableViewCell: UITableViewCell {

   static let identifier = "CollectionViewTableViewCell"
    
    private var titles: [Movie] = [Movie]()
    weak var delegate: CollectionViewTableViewCellDelegate?
    var videoPreviewVM = VideoPreviewViewModel()
    
    private let collectionView: UICollectionView = {
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize(width: 140, height: 200)
        layOut.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layOut)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collection
    }()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .cyan
        cinfigureCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    // MARK: - Private Functions
    private func cinfigureCollection(){
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(with titles: [Movie]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func getMoviePreview(movieTitle:String, titleOverview: String) {
        
        videoPreviewVM.getYoutubeMovie(movieTitle: movieTitle, titleOverview: titleOverview) { [weak self] videoElement in
            guard let self else {return}
            guard let videoElement else {return}
            let moviePreview = MoviePreview(title: movieTitle, titleOverview: titleOverview, youtubeView: videoElement)
        
            self.delegate?.collectionViewTableViewCellDidTap(self, model: moviePreview)
        }
    }
    
    private func downloadMovieAt(indexPath: IndexPath){
      //  print("Downloading \(titles[indexPath.row].originalName ?? titles[indexPath.row].originalTitle ?? "")")
        let movie = titles[indexPath.row]
        DataPersistenceManager.shared.downloadMovieWith(model: movie) { result in
            switch result {
            case .success():
                print("Downloaded to DataBase")
                
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
// MARK: - CollectionView Delegate & Datasource
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let poster = titles[indexPath.row].posterPath else {return UICollectionViewCell()}
        cell.configure(with: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = titles[indexPath.row]
        guard let movieTitle = movie.originalTitle ?? movie.originalName else {return}
        guard let titleOverview = titles[indexPath.row].overview else {return}
        
        getMoviePreview(movieTitle: movieTitle, titleOverview: titleOverview)

        
    }
  
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let downloadAtion = UIAction(title: "Download",
                                         subtitle: nil,
                                         image: nil,
                                         identifier: nil,
                                         discoverabilityTitle: nil, state: .off) { [weak self] _ in
                self?.downloadMovieAt(indexPath: indexPaths[0])
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAtion])
        }
        
        return config
    }
    
}
