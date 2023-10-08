//
//  VideoPreviewViewModel.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 07/10/2023.
//

import Foundation

class VideoPreviewViewModel {
    
    var bindingResult: ((VideoElement?) -> ())?
    
    
    var moviePreview: VideoElement? {
        didSet{
            bindingResult?(moviePreview)
        }
    }
    
    func getYoutubeMovie(movieTitle: String, titleOverview:String, completion: @escaping ((VideoElement?)-> ())) {
        YoutubeSearch.get_YoutubeSearch(query: movieTitle + " trailer") { [weak self] result in
            
           // guard let self else {return}
            
            switch result {
            case .success(let videoElement):
              //  self.moviePreview = videoElement
                
               // let moviePreview = moviePreview
               // MoviePreview(title: movieTitle, titleOverview: titleOverview, youtubeView: videoElement)
                completion(videoElement)
               // self.delegate?.collectionViewTableViewCellDidTap(self, model: moviePreview)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
