//
//  ReviewsTableViewCell.swift
//  KitaBisaSubmission
//
//  Created by Moh Zinnur Atthufail Addausi on 10/03/21.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    static let idReviewTableViewCell = "idReviewTableViewCell"
    
    @IBOutlet weak var imageReviewsTableViewCell: UIImageView!
    @IBOutlet weak var titleReviewsTableViewCell: UILabel!
    @IBOutlet weak var contentReviewsTableViewCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCellDest(images: String?, title: String?, contet: String?) {
        
        setupCircle(imageReviewsTableViewCell)
        guard var image = images else {
            return
        }
        image.remove(at: image.startIndex)
        self.imageReviewsTableViewCell.LoadImage(urlString: image)
     
        self.titleReviewsTableViewCell.text = title
        self.contentReviewsTableViewCell.text = contet
        
    }
    
    func setupCircle(_ image: UIImageView) {
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.size.height/2
    }
    
}
