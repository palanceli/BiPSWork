//
//  Ch18RoundedTextField.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/17.
//

import UIKit

class Ch18RoundedTextField: UITextField {
    // 设置缩进尺寸
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);
    
    // 返回画text的矩形
    override func textRect(forBounds bounds: CGRect) -> CGRect{
      return bounds.inset(by: padding)
    }
    
    // 返回placeholder文本的矩形
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    // 返回输入文本的矩形
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    // 每次重新布局时调用
    override func layoutSubviews() {
      super.layoutSubviews()
      
      self.layer.borderWidth = 1.0  // 边框宽度
      self.layer.borderColor = UIColor.systemGray5.cgColor  // 边框颜色
      self.layer.cornerRadius = 10.0   // 圆角弧度
      self.layer.masksToBounds = true
    }
}
