//
// AttractionType.swift
// ============================


import UIKit

// Preferences are set by passing an array of AttractionTypes to endpoint
class AttractionType: NSObject {
    
    var id: Int?
    var name: String?
    var icon: UIImage?
    var color: UIColor?
    var rawData: NSDictionary!
    
    init(categoryName: String, categoryIcon: String, categoryColor: UIColor) {
        name = categoryName
        icon = UIImage(named: categoryIcon)
        color = categoryColor
    }
    
    init(name: String) {
        super.init()
        self.name = name as String
    }
    
    class func attractionTypesWithArray(array: [String]) -> [AttractionType] {
        var attractionTypes = [AttractionType]()
        
        UIColor.fomoBlue()
        
        for name in array {
            attractionTypes.append(AttractionType(name: name))
        }
        
        return attractionTypes
    }
    
    class func generateTestInstance() -> AttractionType {
        let attractionType = AttractionType(categoryName: "Landmarks", categoryIcon: "landmarks", categoryColor: UIColor.landmarks())
        attractionType.id = 1
        return attractionType
    }
    
    class func availableCategories() -> [AttractionType] {
        var categories: [AttractionType] = []
        categories.append(AttractionType(categoryName: "Culture", categoryIcon: "culture", categoryColor: UIColor.culture()))
        categories.append(AttractionType(categoryName: "Landmarks", categoryIcon: "landmarks", categoryColor: UIColor.landmarks()))
        categories.append(AttractionType(categoryName: "Outdoors", categoryIcon: "outdoors", categoryColor: UIColor.outdoors()))
        categories.append(AttractionType(categoryName: "Shows", categoryIcon: "shows", categoryColor: UIColor.shows()))
        categories.append(AttractionType(categoryName: "Night Life", categoryIcon: "nightlife", categoryColor: UIColor.nightlife()))
        categories.append(AttractionType(categoryName: "Shopping", categoryIcon: "shopping", categoryColor: UIColor.shopping()))
        categories.append(AttractionType(categoryName: "Sports", categoryIcon: "sports", categoryColor: UIColor.sports()))
        categories.append(AttractionType(categoryName: "Food", categoryIcon: "restaurants", categoryColor: UIColor.restaurants()))
        categories.append(AttractionType(categoryName: "Vices", categoryIcon: "vices", categoryColor: UIColor.vices()))
        return categories
    }
}