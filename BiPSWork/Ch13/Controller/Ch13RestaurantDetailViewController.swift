//
//  Ch13RestaurantDetailViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/12.
//

import UIKit

class Ch13RestaurantDetailViewController: UIViewController {
    @IBOutlet var restaurantImageView: UIImageView!
    var restaurantImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantImageView.image = UIImage(named: restaurantImageName)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


}
