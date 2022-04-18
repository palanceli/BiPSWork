//
//  Ch11RestaurantTableViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/9.
//

import UIKit

class Ch12RestaurantTableViewController: UITableViewController {
    var restaurants:[Ch11Restaurant] = [
        Ch11Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong",
                   image: "cafedeadend", isFavorite: false),
        Ch11Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei",
                   isFavorite: false),
        Ch11Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong",
                   image: "teakha", isFavorite: false),
        Ch11Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink",
                   location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Ch11Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong",
                   image: "petiteoyster", isFavorite: false),
        Ch11Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong",
                   image: "forkee", isFavorite: false),
        Ch11Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong",
                   image: "posatelier", isFavorite: false),
        Ch11Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney",
                   image: "bourkestreetbakery", isFavorite: false),
        Ch11Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney",
                   image: "haigh", isFavorite: false),
        Ch11Restaurant(name: "Palomino Espresso", type: "American / Seafood",
                   location: "Sydney", image: "palomino", isFavorite: false),
        Ch11Restaurant(name: "Upstate", type: "American", location: "New York",
                   image: "upstate", isFavorite: false),
        Ch11Restaurant(name: "Traif", type: "American", location: "New York",
                   image: "traif", isFavorite: false),
        Ch11Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch",
                   location: "New York", image: "graham", isFavorite: false),
        Ch11Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York",
                   image: "waffleandwolf", isFavorite: false),
        Ch11Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York",
                   image: "fiveleaves", isFavorite: false),
        Ch11Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York",
                   image: "cafelore", isFavorite: false),
        Ch11Restaurant(name: "Confessional", type: "Spanish", location: "New York",
                   image: "confessional", isFavorite: false),
        Ch11Restaurant(name: "Barrafina", type: "Spanish", location: "London",
                   image: "barrafina", isFavorite: false),
        Ch11Restaurant(name: "Donostia", type: "Spanish", location: "London",
                   image: "donostia", isFavorite: false),
        Ch11Restaurant(name: "Royal Oak", type: "British", location: "London",
                   image: "royaloak", isFavorite: false),
        Ch11Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London",
                   image: "cask", isFavorite: false)
    ]

    // 定义所有section，本例中只有一个
    enum Section {
        case all
    }

    lazy var dataSource = configureDataSource()

    func configureDataSource()->Ch12RestaurantDiffableDataSource<Section, Ch11Restaurant>{
        let cellID = "ch12FavoriteCell"

        let dataSource = Ch12RestaurantDiffableDataSource<Section, Ch11Restaurant>(
            tableView: tableView, cellProvider: {tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Ch12RestaurantTableViewCell
                cell.nameLabel.text = restaurant.name
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.thumbnailImageView.image = UIImage(named: restaurant.image)

                if restaurant.isFavorite{
                    cell.accessoryType = .checkmark
                }else{
                    cell.accessoryType = .none
                }
                return cell
            })
        return dataSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<Section, Ch11Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(self.restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.separatorStyle = .none
        // 自动调整单元格的宽度，不至于在宽屏设备下太宽
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 创建Alert菜单
        let optionMenu = UIAlertController(title: nil, message: "你想弄啥咧？", preferredStyle: .actionSheet)

        // 适配iPad，应该是制定菜单的弹出位置靠近哪一个单元格
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }

        // 添加cancel行动项
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        // 添加Reserve行动项
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: {(action:UIAlertAction!) -> Void in
            let alertMsg = UIAlertController(title: "施工中", message: "抱歉，该功能正在建设中，请稍后再试", preferredStyle: .alert)
            alertMsg.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMsg, animated: true, completion: nil)
        })
        optionMenu.addAction(reserveAction)

        // 添加favorite行动项
        var favoriteTitle = "收藏"
        if restaurants[indexPath.row].isFavorite{
            favoriteTitle = "取消收藏"
        }
        let favoriteAction = UIAlertAction(title: favoriteTitle, style: .default, handler: {(action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            if !self.restaurants[indexPath.row].isFavorite{
                // tableView 单元格的右侧保留了四种内建视图：显示指示器、详情、复选、详细信息
                // 这里使用复选
                cell?.accessoryType = .checkmark
                cell?.tintColor = .systemYellow
                self.restaurants[indexPath.row].isFavorite = true
            }else{
                cell?.accessoryType = .none
                self.restaurants[indexPath.row].isFavorite = false
            }
        })
        optionMenu.addAction(favoriteAction)

        // 弹出Alert菜单
        present(optionMenu, animated: true)
        // 取消被点击项的选中状态，否则会有个灰色背景
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 获取被选中的一行
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath)
        else{
            return UISwipeActionsConfiguration()
        }

        // 添加“删除”菜单
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {(action, sourceView, completionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: false)
            completionHandler(true)
        })
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")

        // 添加“分享”菜单
        let shareAction = UIContextualAction(style: .normal, title: "Share", handler: {(action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(named: restaurant.image){
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            }else{
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            self.present(activityController, animated: true)
            completionHandler(true)
        })
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")

        // 装配两个菜单
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }

}
