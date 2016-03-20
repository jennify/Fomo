//
// AttractionType.swift
// ============================


import UIKit

// Preferences are set by passing an array of AttractionTypes to endpoint
class AttractionType: NSObject {
    
    var id: Int?
    var name: String?
    var icon: UIImage?
    var rawData: NSDictionary!
    
    init(categoryName: String, categoryIcon: String) {
        name = categoryName
        icon = UIImage(named: categoryIcon)
    }
    
    init(name: String) {
        super.init()
        self.name = name as String
    }
    
    class func attractionTypesWithArray(array: [String]) -> [AttractionType] {
        var attractionTypes = [AttractionType]()
        
        for name in array {
            attractionTypes.append(AttractionType(name: name))
        }
        
        return attractionTypes
    }
    
    class func generateTestInstance() -> AttractionType {
        let attractionType = AttractionType(categoryName: "Landmarks", categoryIcon: "landmarks")
        attractionType.id = 1
        return attractionType
    }
    
    class func availableCategories() -> [AttractionType] {
        var categories: [AttractionType] = []
        categories.append(AttractionType(categoryName: "Culture", categoryIcon: "culture"))
        categories.append(AttractionType(categoryName: "Landmarks", categoryIcon: "landmarks"))
        categories.append(AttractionType(categoryName: "Outdoors", categoryIcon: "outdoors"))
        categories.append(AttractionType(categoryName: "Shows", categoryIcon: "shows"))
        categories.append(AttractionType(categoryName: "Night Life", categoryIcon: "nightlife"))
        categories.append(AttractionType(categoryName: "Shopping", categoryIcon: "shopping"))
        categories.append(AttractionType(categoryName: "Sports", categoryIcon: "sports"))
        categories.append(AttractionType(categoryName: "Restaurants", categoryIcon: "restaurants"))
        categories.append(AttractionType(categoryName: "Vices", categoryIcon: "vices"))
        return categories
    }
}