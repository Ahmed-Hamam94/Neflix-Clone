//
//  HomeViewModel.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 03/10/2023.
//

import Foundation

protocol TrendingMoviesVMProtocol {
    func callFuncToGetTrendingMovies(completionHandler:@escaping (Bool) -> Void)
    func callFuncToGetTrendingTV(completionHandler:@escaping (Bool) -> Void)
    func callFuncToGetUpComing(completionHandler:@escaping (Bool) -> Void)
    func callFuncToGetPopular(completionHandler:@escaping (Bool) -> Void)
    func callFuncToGetTopRated(completionHandler:@escaping (Bool) -> Void)

    var bindingResult: (()->())? {get set}
    
    var trendingMovies: [Movie]? {get set}
    var trendinTV: [TV]? {get set}
    var upComing: [ComingMovies]? {get set}
    var popularMovies: [Movie]? {get set}
    var topRatedMovies: [Movie]? {get set}
}


class HomeViewModel: TrendingMoviesVMProtocol{
    
    var service: TrendingMoviesProtocol?
    var tvService: TrendingTvProtocol?
    var upComing_service: upComingProtocol?
    var popular_service: PopularProtocol?
    var topRated_service: TopRatedProtocol?
    
    var bindingResult: (()->())?
    
    var trendingMovies: [Movie]? {
        didSet{
            bindingResult?()
        }
    }
    
    var trendinTV: [TV]? {
        didSet {
            bindingResult?()
        }
    }
    
    var upComing: [ComingMovies]? {
        didSet{
            bindingResult?()
        }
    }
    
    var popularMovies: [Movie]? {
        didSet{
            bindingResult?()
        }
    }
    
    var topRatedMovies: [Movie]? {
        didSet {
            bindingResult?()
        }
    }
    
    init(service: TrendingMoviesProtocol, tvService: TrendingTvProtocol, upComing_service: upComingProtocol, popular_service: PopularProtocol, topRated_service: TopRatedProtocol){
        self.service = service
        self.tvService = tvService
        self.upComing_service = upComing_service
        self.popular_service = popular_service
        self.topRated_service = topRated_service
    }
    
    
    func callFuncToGetTrendingMovies(completionHandler:@escaping (Bool) -> Void){
        service?.getTrendingMovies(completion: { [weak self] result in
            completionHandler(false)
            switch result {
            case .success(let movies):
                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
               print(movies)
                self?.trendingMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
        
      
        
    }
    
    func callFuncToGetTrendingTV(completionHandler:@escaping (Bool) -> Void){
        
        tvService?.getTrendingTV(completion: { [weak self] result in
            
            completionHandler(false)
            
            switch result {
            case .success(let tv):
                print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
                print(tv)
                self?.trendinTV = tv
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completionHandler(true)
        })
    }
    
    func callFuncToGetUpComing(completionHandler:@escaping (Bool) -> Void){
        
        upComing_service?.getUpComingMovies(completion: { [weak self] result in
            
            completionHandler(false)
            
            switch result {
            case .success(let upComingMovies):
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                print(upComingMovies)
                self?.upComing = upComingMovies
            case .failure(let error):
                print("fail???>>\(error.localizedDescription)")
            }
            
            completionHandler(true)
        })
        
     
    }

    func callFuncToGetPopular(completionHandler:@escaping (Bool) -> Void){
        popular_service?.getPopularMovies(completion: { [weak self] result in
            completionHandler(false)
            switch result {
            case .success(let popularMovies):
                print("{}}{}{}{}{}{{}{}{}{}{}{{}{}{}{}{}{}{}{}{{}{}{}{}{}{}{}{}")
               print(popularMovies)
                self?.popularMovies = popularMovies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
    }
    
    func callFuncToGetTopRated(completionHandler:@escaping (Bool) -> Void){
        
        topRated_service?.getTopRated(completion: { [weak self] result in
            completionHandler(false)
            switch result {
            case .success(let topRatedMovies):
                print("++++______+++++++______+++++++_______++++++")
               print(topRatedMovies)
                self?.topRatedMovies = topRatedMovies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
    }

    
}
