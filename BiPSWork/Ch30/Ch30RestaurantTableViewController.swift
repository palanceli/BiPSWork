//
//  Ch30RestaurantTableViewController.swift
//  BiPSWork
//
//  Created by palance on 2022/4/20.
//

import UIKit
import CoreData

class Ch30RestaurantTableViewController: UITableViewController {
    // 定义所有section，本例中只有一个
    enum Section {
        case all
    }
    
    @IBOutlet var emptyRestaurantView: UIView!
    
    var restaurants:[Ch19Restaurant] = []
    
    lazy var dataSource = configureDataSource()
    
    // 缓存查询列表
    var fetchResultController: NSFetchedResultsController<Ch19Restaurant>!
    
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
    func fetchRestaurantData(){
        let fetchRequest: NSFetchRequest<Ch19Restaurant> = Ch19Restaurant.fetchRequest()
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

    func configureDataSource()->Ch12RestaurantDiffableDataSource<Section, Ch19Restaurant>{
        let cellID = "ch30FavoriteCell"

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


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        prepareNotification()  // 启动通知
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
    
    // MARK: - User Notification
    
    func prepareNotification() {
        if restaurants.count <= 0 {
            return
        }

        // 随机挑选一个restaurant
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]

        // 创建用户通知
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        content.userInfo = ["phone": suggestedRestaurant.phone]
        
        // 把对应图片写入临时目录
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")

        if let image = UIImage(data: suggestedRestaurant.image as Data) {

            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
        // ① 创建两个行动点
        // “预定” 点击后将在前台弹出界面
        let categoryIdentifer = "foodpin.restaurantaction"
        let makeReservationAction = UNNotificationAction(identifier: "foodpin.makeReservation", title: "Reserve a table", options: [.foreground])
        // “稍后” 点击后在后台处理 options为空则默认后台
        let laterAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, laterAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryIdentifer
        
        // 10秒后弹出
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "foodpin.restaurantSuggestion", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

// 当fetch results发生变化时，协议NSFetchedResultsControllerDelegate将收到通知
extension Ch30RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    // 当数据发生变化时
    // controllerWillChangeContent 和 controllerDidChangeContent 将被调用
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}
