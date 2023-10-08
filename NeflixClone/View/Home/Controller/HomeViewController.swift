//
//  HomeViewController.swift
//  NeflixClone
//
//  Created by Ahmed Hamam on 02/10/2023.
//

import UIKit
import KRProgressHUD

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
  
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return table
    }()
    
    let sectionTitles: [String] = ["Trending Movies","Trending TV","Popular","Upcoming Movies","Top Rated"]
    private var randomTrendingMoview : Movie?
    private var headerView: HeroHeaderView?
    var tvService: TrendingTvProtocol?
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        tvService = TrendingTV()
        homeViewModel = HomeViewModel(service: TrendingMovies(), tvService: TrendingTV(), upComing_service: upComingMovies(), popular_service: PopularMovies(), topRated_service: TopRated())
       

       
            getMovies()
//            getTV()
//            getUpComing()
//            getPopular()
//            getTopRatedMovies()
       
       
       homeFeedTable.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func setUpUI(){
        view.backgroundColor = .systemBackground
        configureTableView()
        configureHeaderView()
        configureNavBar()
    }
    
    private func configureTableView(){
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    private func configureHeaderView(){
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
       homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavBar(){
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal) // to force ios to use image just as it is
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func getMovies(){
        homeViewModel?.callFuncToGetTrendingMovies(completionHandler: { isFinished in
            if !isFinished {
                //show indicator
                print("//show indicator")
                KRProgressHUD.show()
            }else{
                //dissmiss
                print("//dissmiss indicator")
                KRProgressHUD.dismiss()
            }
        })
    }
    
    private func getTV(){
        homeViewModel?.callFuncToGetTrendingTV(completionHandler: { isFinished in
            if !isFinished {
                //show indicator
                KRProgressHUD.show()
            }else{
                //dissmiss
                KRProgressHUD.dismiss()
            }
        })
    }
    
    private func getUpComing(){
        homeViewModel?.callFuncToGetUpComing(completionHandler: { isFinished in
            if !isFinished {
                //show indicator
                KRProgressHUD.show()
            }else{
                //dissmiss
                KRProgressHUD.dismiss()
            }
        })
    }
    
    private func getPopular(){
        homeViewModel?.callFuncToGetPopular(completionHandler: { isFinished in
            if !isFinished {
                //show indicator
                KRProgressHUD.show()
            }else{
                //dissmiss
                KRProgressHUD.dismiss()
            }
        })
    }
    
    private func getTopRatedMovies(){
        homeViewModel?.callFuncToGetTopRated(completionHandler: { isFinished in
            if !isFinished {
                //show indicator
                KRProgressHUD.show()
            }else{
                //dissmiss
                KRProgressHUD.dismiss()
            }
        })
    }
}

// MARK: - TableView Delegate & Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            homeViewModel?.bindingMovieResult = { [weak self] movies in
                guard let self else {return}
                if let trendingMovies = movies{
                    guard let randomMovie = trendingMovies.randomElement() else{return}
                    self.randomTrendingMoview = randomMovie
                    cell.configure(with: trendingMovies)
                    guard let randomTrending = self.randomTrendingMoview else {return}
                  self.headerView?.configureHeaderWithMovie(with: randomTrending)

                }
            }
            
        case Sections.TrendingTV.rawValue:
           homeViewModel?.bindingResult = { [weak self] in
               if let trendinTV = self?.homeViewModel?.trendinTV{
                  //  print(trendinTV)
                   cell.configure(with: trendinTV)
                }
              
            }

        case Sections.Popular.rawValue:
            if let popularMovies = homeViewModel?.popularMovies{
                cell.configure(with: popularMovies)
            }
        case Sections.UpcomingMovies.rawValue:
            if let upComing = homeViewModel?.upComing{
                cell.configure(with: upComing)
            }
        case Sections.TopRated.rawValue:
            if let topRatedMovies = homeViewModel?.topRatedMovies{
                cell.configure(with: topRatedMovies)
            }
        default:
            return UITableViewCell()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLetter()
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .label
        //        var content = header.defaultContentConfiguration()
        //        content.text = sectionTitles[section]
        //        content.textProperties.font = .systemFont(ofSize: 18, weight: .semibold)
        //        content.textProperties.color = .label
        //        header.contentView.frame = CGRect(x: header.bounds.origin.x + 20,
        //                                          y: header.bounds.origin.y,
        //                                          width: 100,
        //                                          height: header.bounds.height)
        //
        //        header.contentConfiguration = content
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // to push navBar when i scroll top
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
        
    }
}

// MARK: - CollectionViewTableViewCellDelegate
extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTap(_ cell: CollectionViewTableViewCell, model: MoviePreview) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = VideoPreviewViewController()
            vc.configureComponentsWithData(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
    
    
    
    
}


