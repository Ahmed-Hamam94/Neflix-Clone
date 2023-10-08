//
//  SearchViewController.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import UIKit
import KRProgressHUD

class SearchViewController: UIViewController {
    
    private let discoverTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController: UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or Tv Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private var searchMovies: [Movie] = [Movie]()
    
    var searchViewModel: SearchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
searchViewModel = SearchViewModel(service: SearchMovies())
        setUpUI()
        configureTableView()
        getDiscoverMovies()
        renderTable()
        searchController.searchResultsUpdater = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
    
    private func setUpUI(){
        title = "Search"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        navigationItem.searchController = searchController
    }
    private func configureTableView(){
        view.addSubview(discoverTableView)
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
    }
    private func getDiscoverMovies(){
        searchViewModel?.claaFuncToGetSearchMoview(completionHandler: { isFinished in
            if !isFinished {
                KRProgressHUD.show()
            }else{
              //  self?.renderTable()
                KRProgressHUD.dismiss()
               // print(Thread.current)
            }
        })
    }
    private func renderTable(){
        searchViewModel?.bindingResult = { [weak self] searchMovies in
            if let searchMovies = searchMovies {
                self?.searchMovies = searchMovies
             
               // DispatchQueue.main.async {
                    self?.discoverTableView.reloadData()
                    
               // }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        let searchMovie = searchMovies[indexPath.row]
        cell.configure(with: searchMovie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = searchMovies[indexPath.row]
        guard let movieTitle = movie.originalTitle ?? movie.originalName else {return}
        guard let titleOverview = searchMovies[indexPath.row].overview else {return}
        
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

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // get the query from searchbar
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else {return}
        
        resultController.searchResultDelegate = self
        
        searchViewModel?.getSearchResults(query: query)
        
        searchViewModel?.bindingResult = { searchResultMovies in
            if let searchResultMovies = searchResultMovies {
                resultController.searchMovies = searchResultMovies
                
                DispatchQueue.main.async {
                    resultController.searchResultCollectionView.reloadData()
                    
                }
            }
        }
        
    }
}
// MARK: - SearchResultsViewControllerDelegate
extension SearchViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidTap(model: MoviePreview) {
        DispatchQueue.main.async { [weak self] in
            let vc = VideoPreviewViewController()
            vc.configureComponentsWithData(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
