//
//  Ch20RestaurantTableViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/18.
//

import UIKit
import CoreData

class Ch20RestaurantTableViewController: UITableViewController {
    // 定义所有section，本例中只有一个
    enum Section {
        case all
    }
    
    @IBOutlet var emptyRestaurantView: UIView!
    
    var searchController: UISearchController!
    var restaurants:[Ch19Restaurant] = []
    
    lazy var dataSource = configureDataSource()
    // 缓存查询列表
    var fetchResultController: NSFetchedResultsController<Ch19Restaurant>!

    func configureDataSource()->Ch12RestaurantDiffableDataSource<Section, Ch19Restaurant>{
        let cellID = "ch20FavoriteCell"

        let dataSource = Ch12RestaurantDiffableDataSource<Section, Ch19Restaurant>(
            tableView: tableView, cellProvider: {tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Ch12RestaurantTableViewCell
                cell.nameLabel.text = restaurant.name
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.thumbnailImageView.image = UIImage(data: restaurant.image)
                
                if restaurant.isFavorite{
                    cell.accessoryType = .checkmark
                }else{
                    cell.accessoryType = .none
                }
                return cell
            })
        return dataSource
    }
    
    // 更新UI
    func updateSnapshot(animatingChange: Bool = false){
        if let fetchedObjects = fetchResultController.fetchedObjects{
            restaurants = fetchedObjects  // 缓存查询数据
        }
        // 创建快照，更新UI
        var snapshot = NSDiffableDataSourceSnapshot<Section, Ch19Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
    
    // 查询数据
    func fetchRestaurantData(searchText: String = ""){
        let fetchRequest: NSFetchRequest<Ch19Restaurant> = Ch19Restaurant.fetchRequest()
        // 如果查询词非空，则执行谓词逻辑
        if !searchText.isEmpty{
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
        }
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]  // 指定排序规则
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            // 定义查询
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            // 该delegate将在数据发生变化时，收到通知
            fetchResultController.delegate = self
            do{
                try fetchResultController.performFetch()  // 执行查询
                updateSnapshot()
            }catch{
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注意：搜索栏相关代码一定要写在navigationController前面，否则会有显示异常
        // 创建搜索栏，参数为nil表示搜索结果将和列表在同一个窗口
        searchController = UISearchController(searchResultsController: nil)
        // 负责更新搜索结果的实例
        searchController.searchResultsUpdater = self
        // 将搜索栏添加到导航条上
        self.navigationItem.searchController = searchController
        // 在搜索过程中，背景内容是否变暗
        searchController.obscuresBackgroundDuringPresentation = false
        
        // 不要表头被系统状态栏顶下去，直接叠加到状态栏上
//        tableView.contentInsetAdjustmentBehavior = .never
        
        // 注意：原文是在restaurant列表页，即首页设置的，而此处，首页变成了二跳页，
        // 所以设置导航栏只会在真正的首页即上一页生效
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
            
        // Enable large title for navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Ch19Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(self.restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        // 自动调整单元格的宽度，不至于在宽屏设备下太宽
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false: true
        
        fetchRestaurantData()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if searchController.isActive{
            // 如果搜索框被激活，则返回空配置，就不会扫出 删除和分享 按钮了
            return UISwipeActionsConfiguration()
        }
        
        // 获取被选中的restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // 定制“删除”行动点
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                
                // Delete the item
                context.delete(restaurant)
                appDelegate.saveContext()
                
                // Update the view
                self.updateSnapshot(animatingChange: true)
            }
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // 定制“分享”行动点
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(data: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else  {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            // For iPad
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        // 修改按钮颜色
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")

        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
            
        return swipeConfiguration
    }
}

// 当fetch results发生变化时，协议NSFetchedResultsControllerDelegate将收到通知
extension Ch20RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    // 当数据发生变化时
    // controllerWillChangeContent 和 controllerDidChangeContent 将被调用
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}

extension Ch20RestaurantTableViewController: UISearchResultsUpdating{
    // 当搜索框发生变化时，调用该函数
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{
            return
        }
        fetchRestaurantData(searchText: searchText)  // 搜索词非空，则执行搜索
    }
}
