//
//  MovieDetailViewConntrolle.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
// MARK: - Properties
    var moviedata: Result?
    
    static let idMovieDetail = "idMovieDetail"
    static let idMovieDetailnavigate = "idMovieDetailnavigate"
    private var reviewlistViewModel: ReviewViewModelProtocol!
    private var detailistViewModel: DetailViewModelProtocol!
    private let coredatamanager = CoreDataManager()
    
    @IBOutlet weak var titleMovieDetailViewController: UILabel!
    @IBOutlet weak var releasedateMovieDetailViewController: UILabel!
    @IBOutlet weak var overviewMovieDetailViewController: UILabel!
    @IBOutlet weak var imageMovieDetailViewController: UIImageView!
    @IBOutlet weak var TVReviewMovie: UITableView!
    @IBOutlet weak var favouriteButtonDetailViewController: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailistViewModel = DetailViewModel(movieservice: CoreDataManager())
        reviewlistViewModel = ReviewViewModel(reviewservice: ReviewsRemoteDataSource())
        
        TVReviewMovie.separatorStyle = UITableViewCell.SeparatorStyle.none
        TVReviewMovie.tableFooterView = UIView()
        TVReviewMovie.dataSource = self
        
        observe()
        observeStatus()
        registerDetailListCell()
        setinit()
        
        reviewlistViewModel.didload((moviedata?.id)!)
        detailistViewModel.didload(moviedata!)
        
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        self.detailistViewModel.updateStatus(moviedata!)
        detailistViewModel.didload(moviedata!)
    }
}

// MARK: - Helper
extension MovieDetailViewController {
    
    private func registerDetailListCell() {
        let nibName = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        TVReviewMovie.register(nibName, forCellReuseIdentifier: ReviewsTableViewCell.idReviewTableViewCell)
    }
    
    private func registerNoItemCell() {
        guard let  vcnoitem = UIStoryboard(name: "NoItem", bundle: Bundle.main).instantiateViewController(identifier: NoItemMovieViewController.idnoitemreview) as? NoItemMovieViewController else {
            fatalError("NoItemViewController not found")
        }
        TVReviewMovie.backgroundView = vcnoitem.view
    }
    
    private func setinit() {
        self.imageMovieDetailViewController.LoadImage(urlString: "https://image.tmdb.org/t/p/w500/" + (moviedata?.posterPath ?? "") )
        self.titleMovieDetailViewController.text = moviedata?.title
        self.releasedateMovieDetailViewController.text = moviedata?.releaseDate
        self.overviewMovieDetailViewController.text = moviedata?.overview
    }
    
}

// MARK: - Observer
extension MovieDetailViewController {
    private func observe() {
        reviewlistViewModel.list.observe(on: self) { result in
            self.TVReviewMovie.reloadData()
            if result?.isEmpty ?? true {
                self.registerNoItemCell()
                
            } else {
                self.TVReviewMovie.backgroundView = nil
            }
        }
        
        reviewlistViewModel.loading.observe(on: self) { isLoading in
            if isLoading {
                
                self.view.activityStartAnimating(activityColor: .gray, backgroundColor: UIColor.black.withAlphaComponent(0.5))
            } else {
                self.view.activityStopAnimating()
            }
        }
        
    }
    
    private func observeStatus() {
        detailistViewModel.getstatus.observe(on: self) { isStatus in
            if isStatus {
                 self.favouriteButtonDetailViewController.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                
                self.favouriteButtonDetailViewController.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewlistViewModel.list.value?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.reviewlistViewModel.list.value?[indexPath.row]
        
        guard let cell = TVReviewMovie.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.idReviewTableViewCell, for: indexPath) as? ReviewsTableViewCell else {
            fatalError("MovieDetailViewTableViewCell not found")
        }
        
        cell.selectionStyle = .none
        
        cell.initCellDest(images: vm?.authorDetails?.avatarPath, title: vm?.authorDetails?.username, contet: vm?.content)
        
        return cell
    }
    
}
