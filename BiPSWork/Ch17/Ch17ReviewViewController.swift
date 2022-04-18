//
//  Ch17ReviewViewController.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/16.
//

import UIKit

class Ch17ReviewViewController: UIViewController {
    @IBOutlet var rateButtons:[UIButton]!
    @IBOutlet var backgroundImageView: UIImageView!
    var restaurant = Ch11Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.image = UIImage(named: restaurant.image)
        
        // 创建特效视图
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        // 将特效视图添加到背景视图上
        backgroundImageView.addSubview(blurEffectView)
        
//        setFlyInAnimationStart()
        setMultiAnimationStart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setFlyInAnimationEnd()
        setMultiAnimationEnd()
    }
    
    // 动画效果：从右飞入
    func setFlyInAnimationStart(){
        // 定义初始位置：右移600像素
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        // 设置动画的初始状态：所有评价按钮不可见，并向右平移600个点
        for rateButton in rateButtons{
            rateButton.transform = moveRightTransform
            rateButton.alpha = 0
        }
    }
    
    func setFlyInAnimationEnd(){
        // 设置动画的终态：所有评价按钮可见，动画时长2秒钟，并恢复到IB中设置的初始位置
        var delay = 0.1
        for rateButton in rateButtons{
            UIView.animate(withDuration: 0.4, delay: delay, options: [], animations: {
                rateButton.alpha = 1.0
                rateButton.transform = .identity
            }, completion: nil)
            delay += 0.05
        }
    }
    
    // 动画效果：多个动画叠加，从右飞入 + 弹簧效果
    func setMultiAnimationStart(){
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)  // 从右飞入
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)        // 放大
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform) // 叠加
//        let moveScaleTransform = scaleUpTransform

        // Make the button invisible and move off the screen
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
    }
    
    func setMultiAnimationEnd(){
        var delay = 0.1
        for rateButton in rateButtons{
            UIView.animate(withDuration: 2, delay: delay,
                           usingSpringWithDamping: 0.2,  // 控制振动频率
                           initialSpringVelocity: 0.8,   // 控制振幅
                           options: [], animations: {
                rateButton.alpha = 1.0
                rateButton.transform = .identity
            }, completion: nil)
            delay += 0.05
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
