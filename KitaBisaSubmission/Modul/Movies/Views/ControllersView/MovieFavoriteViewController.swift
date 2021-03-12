//
//  MovieFavoriteViewController.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 11/03/21.
//

import Foundation
import UIKit

class MovieFavoriteViewController: UIViewController {
// MARK: - Properties
    @IBOutlet weak var TvListMovieFavorite: UITableView!
    private var favoriteViewModel: FavoriteViewModelProtocol!
    
    static let idMovieDetail = "idFavorite"
    static let idMovieDetailnavigate = "idFavoriteNavigate"
    private let coredatamanager = CoreDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteViewModel = FavoriteViewModel(movieservice: CoreDataManager())
        registerfavoritesListCell()

        self.TvListMovieFavorite.delegate = self
        self.TvListMovieFavorite.dataSource = self
        self.TvListMovieFavorite.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.TvListMovieFavorite.tableFooterView = UIView()
        
        favoriteViewModel.didload()
        observe()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteViewModel.didload()
        self.TvListMovieFavorite.reloadData()
    }
}

// MARK: - Observer
extension MovieFavoriteViewController {
    private func observe() {
        favoriteViewModel.list.observe(on: self) { result in
            self.TvListMovieFavorite.reloadData()
            if result?.isEmpty ?? true {
                self.registerNoItemCell()
                
            } else {
                self.TvListMovieFavorite.backgroundView = nil
            }
        }
        
        favoriteViewModel.loading.observe(on: self) { isLoading in
            if isLoading {
                self.view.activityStartAnimating(activityColor: .gray, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            } else {
                self.view.activityStopAnimating()
            }
        }
        
        favoriteViewModel.route.observe(on: self) { route in
            switch route {
            
            case .initial:
                break
                
            case .detailfavourites(let datamovie):
                guard let vc =
                        UIStoryboard(name: "MovieDetails", bundle: Bundle.main).instantiateViewController(identifier: MovieDetailViewController.idMovieDetailnavigate) as? UINavigationController else {
                    fatalError("UINavigationController not found")
                }
                
                guard let vcNavigate = vc.viewControllers.first as? MovieDetailViewController else {
                    return
                }
                vcNavigate.moviedata = Result(id: Int(datamovie.id), overview: datamovie.overview, posterPath: datamovie.posterpath, releaseDate: datamovie.releasedate, title: datamovie.title)
                
                self.navigationController?.pushViewController(vcNavigate, animated: true)
            }
            
        }
    }
}

// MARK: - Helper
extension MovieFavoriteViewController {
    
    func registerfavoritesListCell() {
        
        let nibName = UINib(nibName: "MovieTableViewCell", bundle: nil)
        TvListMovieFavorite.register(nibName, forCellReuseIdentifier: MovieTableViewCell.idMovieTableViewCell)
    }
    
    func registerNoItemCell() {
        guard let  vcnoitem = UIStoryboard(name: "NoItem", bundle: Bundle.main).instantiateViewController(identifier: NoItemMovieViewController.idnoitemmovie) as? NoItemMovieViewController else {
            fatalError("NoItemMovieViewController not found")
        }
        
        TvListMovieFavorite.backgroundView = vcnoitem.view
    }
    
}

// MARK: - UITableViewDelegate
extension MovieFavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let position = indexPath.row
        let vm = self.favoriteViewModel.list.value?[position]
        self.favoriteViewModel.route.value = .detailfavourites(vm!)
        
    }
}

// MARK: - UITableViewDataSource
extension MovieFavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.favoriteViewModel.list.value?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let vm = self.favoriteViewModel.list.value?[indexPath.row]
        
        guard let cell = TvListMovieFavorite.dequeueReusableCell(withIdentifier: MovieTableViewCell.idMovieTableViewCell, for: indexPath) as? MovieTableViewCell else {
            fatalError("MovieFavoriteListViewTableViewCell not found")
        }
        
        cell.selectionStyle = .none
        
        cell.initCellDest(images: vm?.posterpath, title: vm?.title, releasedate: vm?.releasedate, overview: vm?.overview)
        
        return cell
    }
    
}
