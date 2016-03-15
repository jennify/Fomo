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
    
    init(cityName: String, imageName: String, cityLocation: CLLocation) {
        name = cityName
        coverPhoto = UIImage(named: imageName)
        radius = 5000
        location = cityLocation
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
        cities.append(City(cityName: "San Francisco", imageName: "SanFrancisco", cityLocation: CLLocation(latitude: 37.7833, longitude: 122.4167)))
        cities.append(City(cityName: "Paris", imageName: "Paris", cityLocation: CLLocation(latitude: 48.8567, longitude: 2.3508)))
        cities.append(City(cityName: "Rio De Janeiro", imageName: "RioDeJaneiro", cityLocation: CLLocation(latitude: 22.9068, longitude: 43.1729)))
        return cities
    }
}