//
//  Ch21WalkthroughViewController.swift
//  BiPSWork
//
//  Created by palance on 2022/4/18.
//

import UIKit

class Ch21WalkthroughViewController: UIViewController {
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!{
        didSet{
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    var walkthroughPageViewController: Ch21WalkthroughPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    // MARK: - Navigation

    // PageViewController是通过Segue和本VC关联在一起的，因此可以通过prepare获取PageViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? Ch21WalkthroughPageViewController{
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self // 设置划屏代理为自己
        }
    }
    
    @IBAction func nextButtonTapped(sender: UIButton){
        if let index = walkthroughPageViewController?.currentIndex{
            switch index{
            case 0...1:
                // 更新PageViewController内部内容
                walkthroughPageViewController?.forwardPage()
            case 2:
                // 向导页在app整个生命周期只显示一次
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                break
            default:
                break
            }
        }
        updateUI()  // 更新本VC界面
    }
    
    func updateUI(){
        if let index = walkthroughPageViewController?.currentIndex{
            switch index{
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("Get Started", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
}

extension Ch21WalkthroughViewController: WalkthroughPageViewControllerDelegate
{
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
} }
