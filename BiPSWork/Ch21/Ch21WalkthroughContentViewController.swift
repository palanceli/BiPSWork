//
//  Ch21WalkthroughContentViewController.swift
//  BiPSWork
//
//  Created by palance on 2022/4/18.
//

import UIKit

class Ch21WalkthroughContentViewController: UIViewController {
    @IBOutlet var headingLabel: UILabel!{
        didSet{
            headingLabel.numberOfLines = 0  // 支持多行
        }
    }
    @IBOutlet var subHeadingLabel: UILabel!{
        didSet{
            subHeadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var contentImageView: UIImageView!
    
    var index = 0       // 当前页序号
    var heading = ""
    var subHeading = ""
    var imageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }
}
