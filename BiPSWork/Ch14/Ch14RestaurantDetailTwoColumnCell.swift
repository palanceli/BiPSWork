//
//  Ch14RestaurantDetailTwoColumnCell.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/13.
//

import UIKit

class Ch14RestaurantDetailTwoColumnCell: UITableViewCell {
    @IBOutlet var column1TitleLabel: UILabel!{
        didSet{
            column1TitleLabel.text = column1TitleLabel.text?.uppercased()
            column1TitleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var column1TextLabel:UILabel!{
        didSet{
            column1TextLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var column2TitleLabel:UILabel!{
        didSet{
            column2TitleLabel.text = column2TitleLabel.text?.uppercased()
            column2TitleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var column2TextLabel:UILabel!{
        didSet{
            column2TextLabel.numberOfLines = 0
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
