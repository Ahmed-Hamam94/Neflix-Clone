//
//  DataPersistenceManager.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 08/10/2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()
        
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context: NSManagedObjectContext?
    
    private init() {
        context = appDelegate.persistentContainer.viewContext
    }

    func downloadMovieWith(model: Movie, completion: @escaping ( (Result<Void, Error>)-> Void) ){
        
        guard let context else {return}
        let item = NetflixItem(context: context)
        
        item.id = Int64(model.id ?? 0)
        item.originalTitle = model.originalTitle
        item.originalName = model.originalName
        item.title = model.title
        item.overview = model.overview
        item.posterPath = model.posterPath
        item.mediaType = model.mediaType
        item.releaseDate = model.releaseDate
        item.voteAverage = model.voteAverage ?? 0.0
        item.voteCount = Int64(model.voteCount ?? 0)
        
        do {
            try context.save()
            completion(.success(()))
        }catch(let error){
            completion(.failure(error))
        }
    }
    
    func fetchingMoviesFromCoreData(completion: @escaping ( (Result<[NetflixItem], Error>)-> Void) ){
        
        let request: NSFetchRequest<NetflixItem>
        request = NetflixItem.fetchRequest()
        
        do {
            guard let movies = try context?.fetch(request) else {return}
            completion(.success(movies))
        }catch(let error){
            completion(.failure(error))
        }

    }
    
    func deleteMovieWith(model: NetflixItem, completion: @escaping ( (Result<Void, Error>)-> Void) ){
        
        context?.delete(model)
        
        do {
            try context?.save()
            completion(.success(()))
        }catch(let error){
            completion(.failure(error))
        }
    }
   
}
