//
//  DownloadsViewController.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private let downloadTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()

    private var downloadedMovies: [NetflixItem] = [NetflixItem]()
    var videoPreviewVM = VideoPreviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUpUI()
        getMoviesFromCoreData()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { [weak self] _ in
            self?.getMoviesFromCoreData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTableView.frame = view.bounds
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUpUI(){
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        configureTableView()
    }

    private func configureTableView(){
        view.addSubview(downloadTableView)
        downloadTableView.delegate = self
        downloadTableView.dataSource = self
    }
    
    private func getMoviesFromCoreData(){
        DataPersistenceManager.shared.fetchingMoviesFromCoreData { [weak self] result in
            guard let self else {return}
            
            switch result {
            case .success(let downloadedMovies):
                self.downloadedMovies = downloadedMovies
                DispatchQueue.main.async {
                    self.downloadTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getMoviePreview(movieTitle:String, titleOverview: String) {
        
        videoPreviewVM.getYoutubeMovie(movieTitle: movieTitle, titleOverview: titleOverview) { [weak self] videoElement in
            guard let self else {return}
            guard let videoElement else {return}
            let moviePreview = MoviePreview(title: movieTitle, titleOverview: titleOverview, youtubeView: videoElement)
        
            DispatchQueue.main.async {
                                   let vc = VideoPreviewViewController()
                                   vc.configureComponentsWithData(with: moviePreview)
                                   self.navigationController?.pushViewController(vc, animated: true)
                               }
        }
    }
}

extension DownloadsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        let downloadedMovie = downloadedMovies[indexPath.row]
       // cell.textLabel?.text = upcomongTitles[indexPath.row].title
        cell.configureDownloadedMovie(with: downloadedMovie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            
        case .delete:
            let movie = downloadedMovies[indexPath.row]
           
            DataPersistenceManager.shared.deleteMovieWith(model: movie) { result in
                switch result {
                case .success():
                    print("Deleted From DataBase")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            self.downloadedMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        @unknown default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = downloadedMovies[indexPath.row]
        guard let movieTitle = movie.originalTitle ?? movie.originalName else {return}
        guard let titleOverview = downloadedMovies[indexPath.row].overview else {return}
        
        getMoviePreview(movieTitle: movieTitle, titleOverview: titleOverview)
        

    }
}
