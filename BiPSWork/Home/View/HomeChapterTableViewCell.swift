//
//  HomeChapterTableViewCell.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/5.
//

import UIKit

class HomeChapterTableViewCell: UITableViewCell {
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var descriptionLable: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
