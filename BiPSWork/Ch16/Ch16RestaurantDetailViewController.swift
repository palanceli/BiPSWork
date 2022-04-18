//
//  Ch16RestaurantDetailViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/15.
//

import UIKit

class Ch16RestaurantDetailViewController: UIViewController {
    // 为什么这里headerView的类是自定义的，而tableView就不需要自定义呢？tableView 也有一些自己的定制数据。
    // 原因是tableView的绘制和数据定制被托管给dataSource和delegate了，当这两个角色委托给
    // Ch16RestaurantDetailViewController，定制工作就在该类里实现了，而不是tableView，所以不需要自定义
    
    @IBOutlet var headerView: Ch14RestaurantDetailHeaderView!
    @IBOutlet var tableView: UITableView!
    
    var restaurant: Ch11Restaurant = Ch11Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 导航栏大字体
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // 不要表头被系统状态栏顶下去，直接叠加到状态栏上
        tableView.contentInsetAdjustmentBehavior = .never
        
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        let heartImage = restaurant.isFavorite ? "heart.fill":"heart"
        headerView.heartButton.tintColor = restaurant.isFavorite ? .systemYellow: .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 上划不再隐藏导航栏
        self.navigationController?.hidesBarsOnSwipe = false
        // 上一页设置了上划隐藏导航栏，因此这里需要恢复显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Ch16ShowMap"{
            let destinationController = segue.destination as! Ch16MapViewController
            destinationController.restaurant = restaurant
        }
    }
    

}

extension Ch16RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate{
    // 返回单元格数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Ch16RestaurantDetailMapCell.self), for: indexPath) as! Ch16RestaurantDetailMapCell
            cell.configure(location: restaurant.location)
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}
