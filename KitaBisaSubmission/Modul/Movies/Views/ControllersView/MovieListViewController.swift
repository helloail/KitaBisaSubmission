//
//  MovieListViewController.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {

// MARK: - Properties
    @IBOutlet weak var TVListMovie: UITableView!
    
    @IBAction func RigtBarButtonFavorite(_ sender: Any) {
        self.movielistViewModel.route.value = .favorite
    }
    
    @IBAction func ButtonMovieSelection(_ sender: Any) {
        sideLayout()

    }
    private var movielistViewModel: MovieViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movielistViewModel = MovieViewModel(movieservice: MovieRemoteDataSource())
        
        self.TVListMovie.dataSource = self
        self.TVListMovie.delegate = self
        TVListMovie.separatorStyle = UITableViewCell.SeparatorStyle.none
        TVListMovie.tableFooterView = UIView()
        
        observe()
        load("popular")
        registerGamesListCell()
    }
    
}

// MARK: - Observer
extension MovieListViewController {
    private func observe() {
        movielistViewModel.list.observe(on: self) { result in
            self.TVListMovie.reloadData()
            if result?.isEmpty ?? true {
                self.registerNoItemCell()
                
            } else {
                self.TVListMovie.backgroundView = nil
            }
        }
        
        movielistViewModel.loading.observe(on: self) { isLoading in
            if isLoading {
                self.view.activityStartAnimating(activityColor: .gray, backgroundColor: UIColor.black.withAlphaComponent(0.5))

            } else {
                self.view.activityStopAnimating()
            }
        }
        movielistViewModel.route.observe(on: self) { route in
            switch route {
            case .initial :
                break
                
            case .favorite:
                guard let vc = UIStoryboard(name: "Favorite", bundle: Bundle.main)
                        .instantiateViewController(identifier: MovieFavoriteViewController.idMovieDetailnavigate) as? UINavigationController else {
                    fatalError("UINavigationController not found")
                }
                
                guard let vcNavigate = vc.viewControllers.first as? MovieFavoriteViewController else {
                    return
                }
                
                self.navigationController?.pushViewController(vcNavigate, animated: true)
                
            case .detailgames(let datamovie):
                guard let vc =
                        UIStoryboard(name: "MovieDetails", bundle: Bundle.main).instantiateViewController(identifier: MovieDetailViewController.idMovieDetailnavigate) as? UINavigationController else {
                    fatalError("UINavigationController not found")
                }
                
                guard let vcNavigate = vc.viewControllers.first as? MovieDetailViewController else {
                    return
                }
                
                vcNavigate.moviedata = datamovie
                
                self.navigationController?.pushViewController(vcNavigate, animated: true)
            }
            
        }
    }
}

// MARK: - Helper
extension MovieListViewController {
    
    func registerGamesListCell() {
        
        let nibName = UINib(nibName: "MovieTableViewCell", bundle: nil)
        TVListMovie.register(nibName, forCellReuseIdentifier: MovieTableViewCell.idMovieTableViewCell)
    }
    
    func registerNoItemCell() {
        guard let  vcnoitem = UIStoryboard(name: "NoItem", bundle: Bundle.main).instantiateViewController(identifier: NoItemMovieViewController.idnoitemmovie) as? NoItemMovieViewController else {
            fatalError("NoItemViewController not found")
        }
        
        TVListMovie.backgroundView = vcnoitem.view
    }
    
    func sideLayout() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Movie Option", preferredStyle: .actionSheet)
        let nowplayinngAction = UIAlertAction(title: "Now playing", style: .default) { _ in
            self.load("now_playing")
            
        }
        
        let upcomingAction = UIAlertAction(title: "Upcoming", style: .default) { _ in
            self.load("upcoming")
            
        }
        
        let topratedAction = UIAlertAction(title: "Top rated", style: .default) { _ in
            self.load("top_rated")
           
        }
        
        let popularAction = UIAlertAction(title: "Popular", style: .default) { _ in
            self.load("popular")
           
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(nowplayinngAction)
        optionMenu.addAction(upcomingAction)
        optionMenu.addAction(topratedAction)
        optionMenu.addAction(popularAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    private func load(_ key: String) {
        self.movielistViewModel.didload(key)
        self.TVListMovie.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movielistViewModel.list.value?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.movielistViewModel.list.value?[indexPath.row]
        
        guard let cell = TVListMovie.dequeueReusableCell(withIdentifier: MovieTableViewCell.idMovieTableViewCell, for: indexPath) as? MovieTableViewCell else {
            fatalError("GamesListViewTableViewCell not found")
        }
        
        cell.selectionStyle = .none
        
        cell.initCellDest(images: vm?.posterPath, title: vm?.title, releasedate: vm?.releaseDate, overview: vm?.overview)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let position = indexPath.row
        let vm = self.movielistViewModel.list.value?[position]
        self.movielistViewModel.route.value = .detailgames(vm!)
        
    }
}
