//
//  Ch14RestaurantDetailHeaderView.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/12.
//

import UIKit

class Ch14RestaurantDetailHeaderView: UIView {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var typeLabel:UILabel!{
        didSet{
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0){
                typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet var heartButton:UIButton!
    @IBOutlet var nameLabel:UILabel!{
        didSet{
            nameLabel.numberOfLines = 0 // 设置多行模式
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0){
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
