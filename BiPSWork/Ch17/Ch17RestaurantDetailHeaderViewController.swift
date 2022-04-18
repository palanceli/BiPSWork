//
//  Ch17RestaurantDetailHeaderViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/17.
//

import UIKit

class Ch17RestaurantDetailHeaderView: UIView {
    @IBOutlet var ratingImageView: UIImageView! // 评价图标
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
}
