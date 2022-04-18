//
//  Ch08ViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/6.
//

import UIKit

class Ch08ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var restaurantNames = [
        "Cafe Deadend",                 "Homei",                "Teakha",       "Cafe Loisl",
        "Petite Oyster",                "For Kee Restaurant",   "Po's Atelier", "Bourke Street Bakery",
        "Haigh's Chocolate",            "Palomino Espresso",    "Upstate",      "Traif",
        "Graham Avenue Meats And Deli", "Waffle & Wolf",        "Five Leaves",  "Cafe Lore",
        "Confessional",                 "Barrafina",            "Donostia",     "Royal Oak",
        "CASK Pub and Kitchen"]
                           
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ch08DataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: "ch08-restaurant")
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
