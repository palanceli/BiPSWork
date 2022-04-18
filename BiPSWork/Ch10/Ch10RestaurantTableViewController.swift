//
//  Ch10RestaurantTableViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/6.
//

import UIKit

class Ch10RestaurantTableViewController: UITableViewController {
    enum Section{
        case all
    }
    
    var restaurantNames = [
        "Cafe Deadend",                 "Homei",                "Teakha",       "Cafe Loisl",
        "Petite Oyster",                "For Kee Restaurant",   "Po's Atelier", "Bourke Street Bakery",
        "Haigh's Chocolate",            "Palomino Espresso",    "Upstate",      "Traif",
        "Graham Avenue Meats And Deli", "Waffle & Wolf",        "Five Leaves",  "Cafe Lore",
        "Confessional",                 "Barrafina",            "Donostia",     "Royal Oak",
        "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl",
                            "petiteoyster", "forkee", "posatelier",
                            "bourkestreetbakery", "haigh", "palomino",
                            "upstate", "traif", "graham", "waffleandwolf",
                            "fiveleaves", "cafelore", "confessional", "barrafina",
                            "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
        
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    // 记录单元格的收藏状态
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    lazy var dataSource = configureDataSource()

    func configureDataSource()->UITableViewDiffableDataSource<Section, String>{
        let cellID = "ch10FavoriteCell"

        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView, cellProvider: {tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Ch10RestaurantTableViewCell
                cell.nameLabel.text = restaurantName
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
                
                if self.restaurantIsFavorites[indexPath.row]{
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
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
        if self.restaurantIsFavorites[indexPath.row]{
            favoriteTitle = "取消收藏"
        }
        let favoriteAction = UIAlertAction(title: favoriteTitle, style: .default, handler: {(action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            if !self.restaurantIsFavorites[indexPath.row]{
                // tableView 单元格的右侧保留了四种内建视图：显示指示器、详情、复选、详细信息
                // 这里使用复选
                cell?.accessoryType = .checkmark
                cell?.tintColor = .systemYellow
                self.restaurantIsFavorites[indexPath.row] = true
            }else{
                cell?.accessoryType = .none
                self.restaurantIsFavorites[indexPath.row] = false
            }
        })
        optionMenu.addAction(favoriteAction)
        
        // 弹出Alert菜单
        present(optionMenu, animated: true)
        // 取消被点击项的选中状态，否则会有个灰色背景
        tableView.deselectRow(at: indexPath, animated: false)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
