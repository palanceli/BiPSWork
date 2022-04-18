//
//  Ch15RestaurantDetailViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/14.
//

import UIKit

class Ch15RestaurantDetailViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: Ch14RestaurantDetailHeaderView!
    
    var restaurant: Ch11Restaurant = Ch11Restaurant()

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 导航栏大字体
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // 不要表头被系统状态栏顶下去，直接叠加到状态栏上
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.delegate = self
        tableView.dataSource = self

        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        
        let heartImage = restaurant.isFavorite ? "heart.fill":"heart"
        headerView.heartButton.tintColor = restaurant.isFavorite ? .systemYellow: .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 上划不再隐藏导航栏
        self.navigationController?.hidesBarsOnSwipe = false
        // 上一页设置了上划隐藏导航栏，因此这里需要恢复显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


extension Ch15RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate{
    // 返回单元格数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    // 返回两个单元格的实例
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // 注意：我们在前面把两个单元格的identifier和类名设置成一样了，这样的好处是
            // 在这里不必hardcode identifier，只需要取类名就可以了
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Ch14RestaurantDetailTextCell.self), for: indexPath) as! Ch14RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurant.description
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Ch14RestaurantDetailTwoColumnCell.self), for: indexPath) as! Ch14RestaurantDetailTwoColumnCell
            cell.column1TitleLabel.text = "Address"
            cell.column1TextLabel.text = restaurant.location
            cell.column2TitleLabel.text = "Phone"
            cell.column2TextLabel.text = restaurant.phone
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}
