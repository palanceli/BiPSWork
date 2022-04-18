//
//  Ch12RestaurantDiffableDataSource.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/9.
//

import UIKit

class Ch12RestaurantDiffableDataSource<SectionType: Hashable, ItemType: Hashable>: UITableViewDiffableDataSource<SectionType, ItemType> {
    // 必须重载这个函数，单元格才是可编辑的，才能划出菜单
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 重载了这个函数，单元格才能划出默认的“删除”菜单
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 定义删除菜单的处理逻辑
        if editingStyle == .delete{
            if let restaurant = self.itemIdentifier(for: indexPath){
                var snapshot = self.snapshot()
                snapshot.deleteItems([restaurant])  // 从snapshot中删除该项
                self.apply(snapshot, animatingDifferences: false)
            }
        }
    }
}
