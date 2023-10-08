//
//  UpcominViewController.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import UIKit

class UpcominViewController: UIViewController {

    
    private let upcominTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()

    private var upcomongTitles: [Movie] = [Movie]()
    var upcomingViewModel: UpcomingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        upcomingViewModel = UpcomingViewModel(upComing_service: upComingMovies())
        setUpUI()
        upcomingViewModel?.getUpcoming()
        renderTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcominTableView.frame = view.bounds
    }

    private func setUpUI(){
        title = "UpComing"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        configureTableView()
    }
    private func configureTableView(){
        view.addSubview(upcominTableView)
        upcominTableView.delegate = self
        upcominTableView.dataSource = self
    }
    
    private func renderTableView(){
        upcomingViewModel?.bindingUpcomingResult = { [weak self] upcoming in
            if let upcoming = upcoming {
                self?.upcomongTitles = upcoming
                DispatchQueue.main.async {
                    self?.upcominTableView.reloadData()
                }
               
            }
        }
    }
}

// MARK: - upcominTableView Delegate & Datasource
extension UpcominViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomongTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        let upcomingMovie = upcomongTitles[indexPath.row]
       // cell.textLabel?.text = upcomongTitles[indexPath.row].title
        cell.configure(with: upcomingMovie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = upcomongTitles[indexPath.row]
        guard let movieTitle = movie.originalTitle ?? movie.originalName else {return}
        guard let titleOverview = upcomongTitles[indexPath.row].overview else {return}
        
        YoutubeSearch.get_YoutubeSearch(query: movieTitle + " trailer") { [weak self] result in
            guard let self else {return}
                  switch result {
                  case .success(let videoElement):
                    
                     let moviePreview = MoviePreview(title: movieTitle, titleOverview: titleOverview, youtubeView: videoElement)
                      DispatchQueue.main.async {
                          let vc = VideoPreviewViewController()
                          vc.configureComponentsWithData(with: moviePreview)
                          self.navigationController?.pushViewController(vc, animated: true)
                      }
                      
                      
                  case .failure(let error):
                      print(error.localizedDescription)
                  }
              }
    }
}
