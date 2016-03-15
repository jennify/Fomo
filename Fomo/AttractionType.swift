//
// AttractionType.swift
// ============================


import UIKit

// Preferences are set by passing an array of AttractionTypes to endpoint
class AttractionType: NSObject {
    
    var id: Int?
    var name: String?
    
    class func generateTestInstance() -> AttractionType {
        let attractionType = AttractionType()
        attractionType.id = 1
        attractionType.name = "Bars"
        return attractionType
    }
}
