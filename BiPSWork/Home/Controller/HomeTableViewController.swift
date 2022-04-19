//
//  HomeTableViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/4.
//

import UIKit

class HomeTableViewController: UITableViewController {
    enum Section{
        case all
    }
    let cellID = "HomeCell"
    
    lazy var dataSource = configDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appearance = navigationController?.navigationBar.standardAppearance{
            // 设置导航栏透明
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0){
                // 分别设置LargeTitle和Title字色
                appearance.titleTextAttributes = [.foregroundColor:UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
                appearance.largeTitleTextAttributes = [.foregroundColor:UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0), .font:customFont]
            }
                
            // 常规状态
            navigationController?.navigationBar.standardAppearance = appearance
            // 小屏幕手机横屏的状态
            navigationController?.navigationBar.compactAppearance = appearance
            // 被ScrollView向下拉的状态
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChapterItem>()
        snapshot.appendSections([.all])
        snapshot.appendItems(ChapterFactory.shared.getItems(), toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func configDataSource() -> UITableViewDiffableDataSource<Section, ChapterItem>{
        let dataSource = UITableViewDiffableDataSource<Section, ChapterItem>(
            tableView:tableView,
            cellProvider:{tableView, indexPath, chapterItem in
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID) as! HomeChapterTableViewCell
                cell.titleLable.text = chapterItem.title
                cell.descriptionLable.text = chapterItem.description
                cell.thumbnailImageView.image = UIImage(named: chapterItem.image)
                return cell
            })
        return dataSource
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segueID = ""
        switch indexPath.row{
        case 0:
            segueID = "showCh03"
        case 1:
            segueID = "showCh05"
        case 2:
            segueID = "showCh06"
        case 3:
            segueID = "showCh08"
        case 4:
            segueID = "showCh09"
        case 5:
            segueID = "showCh10"
        case 6:
            segueID = "showCh11"
        case 7:
            segueID = "showCh12"
        case 8:
            segueID = "showCh13"
        case 9:
            segueID = "showCh14"
        case 10:
            segueID = "showCh15"
        case 11:
            segueID = "showCh16"
        case 12:
            segueID = "showCh17"
        case 13:
            segueID = "showCh18"
        case 14:
            segueID = "showCh19"
        case 15:
            segueID = "showCh20"
        case 16:
            segueID = "showCh21"
        default:
            segueID = ""

        }
        if !segueID.isEmpty{
            performSegue(withIdentifier: segueID, sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: false)
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
