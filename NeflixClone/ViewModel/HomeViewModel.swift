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
    var bindingMovieResult: (([Movie]?)->())? {get set}
    
    var trendingMovies: [Movie]? {get set}
    var trendinTV: [Movie]? {get set}
    var upComing: [Movie]? {get set}
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
    var bindingMovieResult: (([Movie]?)->())?
    
    var trendingMovies: [Movie]? {
        didSet{
            bindingMovieResult?(trendingMovies)
        }
    }
    
    var trendinTV: [Movie]? {
        didSet {
            bindingResult?()
        }
    }
    
    var upComing: [Movie]? {
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
             //  print(movies)
                self?.trendingMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
        
        tvService?.getTrendingTV(completion: { [weak self] result in

            completionHandler(false)

            switch result {
            case .success(let tv):
                print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
             // print(tv)
                self?.trendinTV = tv
            case .failure(let error):
                print(error.localizedDescription)
            }

            completionHandler(true)
        })
        
        
        upComing_service?.getUpComingMovies(completion: { [weak self] result in
            
            completionHandler(false)
            
            switch result {
            case .success(let upComingMovies):
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
             //   print(upComingMovies)
                self?.upComing = upComingMovies
            case .failure(let error):
                print("fail???>>\(error.localizedDescription)")
            }
            
            completionHandler(true)
        })
        
        
        popular_service?.getPopularMovies(completion: { [weak self] result in
            completionHandler(false)
            switch result {
            case .success(let popularMovies):
                print("{}}{}{}{}{}{{}{}{}{}{}{{}{}{}{}{}{}{}{}{{}{}{}{}{}{}{}{}")
             //  print(popularMovies)
                self?.popularMovies = popularMovies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
        
        topRated_service?.getTopRated(completion: { [weak self] result in
            completionHandler(false)
            switch result {
            case .success(let topRatedMovies):
                print("++++______+++++++______+++++++_______++++++")
             //  print(topRatedMovies)
                self?.topRatedMovies = topRatedMovies
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        })
    }
    
    func callFuncToGetTrendingTV(completionHandler:@escaping (Bool) -> Void){
        
      
    }
    
    func callFuncToGetUpComing(completionHandler:@escaping (Bool) -> Void){
        
      
        
     
    }

    func callFuncToGetPopular(completionHandler:@escaping (Bool) -> Void){
     
    }
    
    func callFuncToGetTopRated(completionHandler:@escaping (Bool) -> Void){
        
      
    }
   
    
}
