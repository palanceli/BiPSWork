//
//  Ch19Restaurant.swift
//  BiPSWork
//
//  Created by BEI LI on 2022/4/17.
//

import Foundation
import CoreData

class Ch19Restaurant: NSManagedObject {
    // 获取从数据库中返回的Restaurant数据
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ch19Restaurant> {
        return NSFetchRequest<Ch19Restaurant>(entityName: "Ch19Restaurant")
    }

    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var location: String
    @NSManaged public var phone: String
    @NSManaged public var summary: String
    @NSManaged public var image: Data
    @NSManaged public var isFavorite: Bool
    @NSManaged public var ratingText: String?
    
    enum Rating:String{
        case awesome
        case good
        case okay
        case bad
        case terrible
        
        var image: String{
            switch self{
            case .awesome: return "love"
            case .good: return "cool"
            case .okay: return "happy"
            case .bad: return "sad"
            case .terrible: return "angry"
            }
        }
    }
    var rating: Rating?{
        // 将ratingText转换成Rating
        get {
            guard let ratingText = ratingText else{
                return nil
            }
            return Rating(rawValue: ratingText)
        }
        // 将Rating转换成ratingText
        set {
            self.ratingText = newValue?.rawValue
        }
    }
}
