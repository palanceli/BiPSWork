//
//  Ch11Restaurant.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/7.
//

import Foundation
import UIKit

struct Ch11Restaurant:Hashable{
    enum Rating: String{    // 定义评价的数据类型
        case awesome
        case good
        case okay
        case bad
        case terrible
        
        var image: String{
            switch self {
            case .awesome:
                return "love"
            case .good:
                return "cool"
            case .okay:
                return "happy"
            case .bad:
                return "sad"
            case .terrible:
                return "angry"
            }
        }
    }
    
    var name: String
    var type: String
    var location: String
    var image: String
    var imageData: Data?
    var isFavorite: Bool
    var phone: String = ""
    var description: String = ""
    var rating: Rating? // 评价

    
    init(name: String, type: String, location: String, image: String, isFavorite: Bool){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
        self.imageData = UIImage(named: image)?.pngData()
    }
    
    
    init(name: String, type: String, location: String, phone: String, description: String, image: String, isFavorite: Bool){
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.description = description
        self.image = image
        self.isFavorite = isFavorite
    }
    
    init(){
        self.init(name: "", type: "", location: "", image: "", isFavorite: false)
    }
}
