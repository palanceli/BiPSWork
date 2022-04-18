//
//  ChapterItem.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/4.
//

import Foundation

struct ChapterItem: Hashable{
    var title: String = ""
    var description: String = ""
    var image: String = ""
    
    init(title: String, description: String, image: String){
        self.title = title
        self.description = description
        self.image = image
    }
}

class ChapterFactory{
    static let shared = ChapterFactory()
    private init(){}
    
    var chapterItems:[ChapterItem] = [
        ChapterItem(title: "03 构建第一个Swift应用", description: "Hello World", image: "HomeItem-Ch03"),
        ChapterItem(title: "05 自动布局", description: "本章主要介绍自动布局的使用、操作和相关概念", image: "HomeItem-Ch05"),
        ChapterItem(title: "06 使用StackView设计UI", description: "不用编码，仅通过StackView实现适应不同屏幕的布局", image: "HomeItem-Ch06"),
        ChapterItem(title: "08 创建一个基于简单Table的APP", description: "", image: "HomeItem-Ch08"),
        ChapterItem(title: "09 TableView的自定义", description: "Prototype Cell, Diffable Data Source和Dark Mode", image: "HomeItem-Ch09"),
        ChapterItem(title: "10 处理选中事件", description: "响应选中事件，使用UIAlertController显示Alerts", image: "HomeItem-Ch10"),
        ChapterItem(title: "11 面向对象编程", description: "数据全部封装到Ch11Restaurant中，此外还有工程组织和代码管理", image: "HomeItem-Ch10"),
        ChapterItem(title: "12 Table Row左右划操作", description: "响应操作操作，Activity Controller和MVC", image: "HomeItem-Ch12"),
        ChapterItem(title: "13 导航控件和Segue", description: "", image: "HomeItem-Ch13"),
        ChapterItem(title: "14 定制详情页", description: "通过自定义字体、自适应单元格尺寸来定制详情页", image: "HomeItem-Ch14"),
        ChapterItem(title: "15 自定义导航栏，暗黑模式 和 Dynamic Type", description: "", image: "HomeItem-Ch15"),
        ChapterItem(title: "16 使用地图", description: "", image: "HomeItem-Ch16"),
        ChapterItem(title: "17 动画、视觉效果和Unwind Segue", description: "", image: "HomeItem-Ch17"),
        ChapterItem(title: "18 静态表格视图、相机和NSLayoutConstraint", description: "", image: "HomeItem-Ch18"),
        ChapterItem(title: "19 使用Core Data", description: "", image: "HomeItem-Ch19"),
        ChapterItem(title: "20 搜索栏和 UISearchController", description: "", image: "HomeItem-Ch20"),
        ChapterItem(title: "21 构建向导页", description: "使用UIPageViewController and Container Views构建向导页", image: "HomeItem-Ch21"),
        ChapterItem(title: "22 Tab Bar Controller探索 和 Storyboard", description: "", image: "HomeItem-Ch22"),
        ChapterItem(title: "23 使用WKWebView和SFSafariViewController", description: "", image: "HomeItem-Ch23"),
    ]
    
    func getItems()->[ChapterItem]{
        return chapterItems
    }
}
