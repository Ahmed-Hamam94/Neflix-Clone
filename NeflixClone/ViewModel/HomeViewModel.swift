//
//  HomeViewModel.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

protocol TrendingMoviesVMProtocol {
    func callFuncToGetTrendingMovies(completionHandler:@escaping (Bool) -> Void)
    var bindingResult: (()->())? {get set}
    var trendingMovies: [Movie]? {get set}
}


class HomeViewModel: TrendingMoviesVMProtocol{
    
    var service: TrendingMoviesProtocol?
    
    var bindingResult: (()->())?
    
    var trendingMovies: [Movie]? {
        didSet{
            bindingResult?()
        }
    }
    
    init(service: TrendingMoviesProtocol){
        self.service = service
    }
    
    
    func callFuncToGetTrendingMovies(completionHandler:@escaping (Bool) -> Void){
        service?.getTrendingMovies(completion: { [weak self] result in
            completionHandler(false)
            switch result {
            case .success(let movies):
                print("#####################$$$$$$$$$4")
                print(movies)
                self?.trendingMovies = movies
            case .failure(_): break
            }
            completionHandler(true)
        })
    }
    
}
