//
//  Ch14RestaurantDetailViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/12.
//

import UIKit

class Ch14RestaurantDetailViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: Ch14RestaurantDetailHeaderView!

    var restaurant: Ch11Restaurant = Ch11Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 导航栏大字体
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // 设置headerView的图文信息
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        
        // 根据是否选择收藏决定心形按钮的属性
        let heartImage = restaurant.isFavorite ? "heart.fill":"heart"
        headerView.heartButton.tintColor = restaurant.isFavorite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none  // 不显示分割线
    }
}

extension Ch14RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate{
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
