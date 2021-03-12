//
//  MovieTableViewCell.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let idMovieTableViewCell = "idMovieTableViewCell"
    @IBOutlet weak var titleMovieTableViewCell: UILabel!
    @IBOutlet weak var imageMovieTableViewCell: UIImageView!
    @IBOutlet weak var releaseDateMovieTableViewCell: UILabel!
    @IBOutlet weak var overViewTableViewCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCellDest(images: String?, title: String?, releasedate: String?, overview: String?) {
        
        guard let image = images else {
            return
        }
        
        self.imageMovieTableViewCell.LoadImage(urlString: "https://image.tmdb.org/t/p/w500/" + image)
        self.titleMovieTableViewCell.text = title
        self.releaseDateMovieTableViewCell.text = releasedate
        self.overViewTableViewCell.text = overview
    }
    
}
