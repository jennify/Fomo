//
// City.swift
// ============================


import UIKit
import CoreLocation

class City: NSObject {
    
    var id: Int?
    var name: String?
    var location: CLLocation?
    var radius: Int? // Meters
    var attractions: [Attraction]?
    var coverPhoto: UIImage?
    
    override init() {
        super.init()
    }
    
    init(cityName: String, imageName: String) {
        name = cityName
        coverPhoto = UIImage(named: imageName)
    }
    
    class func generateTestInstance() -> City {
        let city = City()
        city.id = 1
        city.name = "San Francisco"
        city.location = CLLocation(latitude: 37.7833, longitude: 122.4167)
        city.radius = 200
        city.attractions = [Attraction.generateTestInstance(city)]
        return city
    }
    
    class func availableCities() -> [City] {
        var cities: [City] = []
        cities.append(City(cityName: "San Francisco", imageName: "SanFrancisco"))
        cities.append(City(cityName: "Paris", imageName: "Paris"))
        cities.append(City(cityName: "Rio De Janeiro", imageName: "RioDeJaneiro"))
        return cities
    }
}