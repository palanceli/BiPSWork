//
//  Ch23AboutTableViewController.swift
//  BiPSWork
//
//  Created by palance on 2022/4/19.
//

import UIKit
import SafariServices

class Ch23AboutTableViewController: UITableViewController {
    enum Section {
        case feedback
        case followus
    }

    struct LinkItem: Hashable {
        var text: String
        var link: String
        var image: String
    }
    
    var sectionContent = [
        // Section0 中的内容
        [LinkItem(text: "Rate us on App Store",
                  link: "https://www.apple.com/ios/app-store/",     image: "store"),
         LinkItem(text: "Tell us your feedback",
                  link: "http://www.appcoda.com/contact",           image: "chat")
        ],
        // Section1 中的内容
        [LinkItem(text: "Twitter",
                  link: "https://twitter.com/appcodamobile",        image: "twitter"),
         LinkItem(text: "Facebook",
                  link: "https://facebook.com/appcodamobile",       image: "facebook"),
         LinkItem(text: "Instagram",
                  link: "https://www.instagram.com/appcodadotcom",  image: "instagram")]
    ]

    lazy var dataSource = configureDataSource()
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        let cellIdentifier = "Ch23AboutCell"
        let dataSource = UITableViewDiffableDataSource<Section, LinkItem>(tableView: tableView) { (tableView, indexPath, linkItem) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            return cell
        }
        return dataSource
    }
    
    func updateSnapshot() {
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus])
        snapshot.appendItems(sectionContent[0], toSection: .feedback)
        snapshot.appendItems(sectionContent[1], toSection: .followus)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 导航栏使用大字体
        navigationController?.navigationBar.prefersLargeTitles = true
            
        // 定制导航栏的外观
        if let appearance = navigationController?.navigationBar.standardAppearance{
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        tableView.dataSource = dataSource
        updateSnapshot()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 获取被选中的link item
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        switch indexPath.section{
        case 0:
            if let url = URL(string: linkItem.link) {
                switch indexPath.row{
                case 0:             // ① 对于Section0/row0，使用Mobile Safari打开
                    UIApplication.shared.open(url)
                default:            // ② 剩下的使用SFSafariViewController打开
                    let safariController = SFSafariViewController(url: url)
                    present(safariController, animated: true, completion: nil)
                }
            }
        case 1:                    // ③ 对于Section1，使用WKWebView打开
                performSegue(withIdentifier: "Ch23ShowWebView", sender: self)
        default:
            break
            
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 传递URL给Segue VC
        if segue.identifier == "Ch23ShowWebView" {
            if let destinationController = segue.destination as? Ch23WebViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let linkItem = self.dataSource.itemIdentifier(for: indexPath) {
                // 将URL传入WebViewController
                destinationController.targetURL = linkItem.link
            }
        }
    }
    

}
