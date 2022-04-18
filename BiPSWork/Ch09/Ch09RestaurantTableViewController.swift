//
//  Ch09RestaurantTableViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/6.
//

import UIKit

class Ch09RestaurantTableViewController: UITableViewController {
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
    
    lazy var dataSource = configureDataSource()

    func configureDataSource()->UITableViewDiffableDataSource<Section, String>{
        let cellID = "ch09DataCell"

        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView, cellProvider: {tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Ch09RestaurantTableViewCell
                cell.nameLabel.text = restaurantName
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
