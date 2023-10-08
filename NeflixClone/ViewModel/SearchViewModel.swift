//
//  SearchViewModel.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 05/10/2023.
//

import Foundation
import KRProgressHUD

protocol SearchVMProtocol {
    func claaFuncToGetSearchMoview(completionHandler: @escaping (Bool)->Void)
    var bindingResult: (([Movie]?)->())? {get set}
    var searchMovies: [Movie]? {get set}
}

class SearchViewModel: SearchVMProtocol{
 
    var service: SearchProtocol?
    
    var bindingResult: (([Movie]?) -> ())?
    
    var searchMovies: [Movie]?{
        didSet{
            bindingResult?(searchMovies)
        }
    }
    
    init(service: SearchProtocol){
        self.service = service
    }
    
    
    func claaFuncToGetSearchMoview(completionHandler: @escaping (Bool) -> Void) {
        
        service?.getSearchMovies(completion: { [weak self] result in

            completionHandler(false)

            switch result {

            case .success(let searchMovies):
                self?.searchMovies = searchMovies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
    }
    
    func getSearchResults(query: String){
        service?.getSearchResult(with: query, completion: { [weak self] result in
         
            switch result {

            case .success(let searchResultMovies):
                self?.searchMovies = searchResultMovies
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
  
}


 
