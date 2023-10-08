//
//  UpcomingViewModel.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 04/10/2023.
//

import Foundation

protocol UpcomingVMProtocol {
    var bindingUpcomingResult: (([Movie]?)->())? {get set}
    var upcoming: [Movie]? {get set}
}

class UpcomingViewModel: UpcomingVMProtocol {
    
    var upComing_service: upComingProtocol?

    var bindingUpcomingResult: (([Movie]?) -> ())?
    
    var upcoming: [Movie]?{
        didSet{
            bindingUpcomingResult?(upcoming)
        }
    }
    
    init(upComing_service: upComingProtocol){
        self.upComing_service = upComing_service
    }
    
    func getUpcoming(){
        upComing_service?.getUpComingMovies(completion: { [weak self] result in
            switch result {
                
            case .success(let upcoming):
                self?.upcoming = upcoming
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
