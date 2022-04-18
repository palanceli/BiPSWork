//
//  Ch14RestaurantDetailTextCell.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/13.
//

import UIKit

class Ch14RestaurantDetailTextCell: UITableViewCell {
    @IBOutlet var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
