//
//  Ch21WalkthroughPageViewController.swift
//  BiPSWork
//
//  Created by palance on 2022/4/18.
//

import UIKit

// 定义协议，告诉代理端当前的页序号
protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class Ch21WalkthroughPageViewController: UIPageViewController {
    // 定义代理端
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    var pageHeadings = ["CREATE YOUR OWN FOOD GUIDE",
                        "SHOW YOU THE LOCATION",
                        "DISCOVER GREAT RESTAURANTS"]
    var pageSubHeadings = ["Pin your favorite restaurants and create your ownfood guide",
                           "Search and locate your favourite restaurant on Maps",
                           "Find restaurants shared by your friends and other foodies"]
    var pageImages = ["onboarding-1",
                      "onboarding-2",
                      "onboarding-3"]
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self // 设置数据源
        // 初始化创建第1个页面
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        delegate = self // 设置划屏代理端
    }
    
    func forwardPage() {
        // 获取下一个ContentViewController
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
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

extension Ch21WalkthroughPageViewController: UIPageViewControllerDataSource {
    // 返回第index个PageContentViewController
    func contentViewController(at index: Int) -> Ch21WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        // 从Onboarding.storyboard中加载PageContentViewController
        let storyboard = UIStoryboard(name: "Ch21", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "Ch21WalkthroughContentViewController") as? Ch21WalkthroughContentViewController {
            // 初始化UI内容
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
    
    // 返回上一个PageContentViewController
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! Ch21WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    // 返回下一个PageContentViewController
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! Ch21WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
}

// 当PageViewController页面划动时，调用该协议方法
extension Ch21WalkthroughPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            // 获取PageViewController的ContentViewController
            if let contentViewController = pageViewController.viewControllers?.first as? Ch21WalkthroughContentViewController {
                // 获取页面序号
                currentIndex = contentViewController.index
                // 通知代理端，按照页号更新相关UI
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        
        }
    }
}
