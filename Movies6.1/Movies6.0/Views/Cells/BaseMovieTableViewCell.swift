//
//  BaseMovieTableViewCell.swift
//  Movies6.0
//
//  Created by Stanislav Tereshchenko on 29.04.2022.
//

import UIKit

class BaseMovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.overviewLabel.numberOfLines = 0
        self.overviewLabel.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func getPoster(url: String) {
        
    }
}
