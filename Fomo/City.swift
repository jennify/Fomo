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
        cities.append(City(cityName: "Rome", imageName: "Rome", cityLocation: CLLocation(latitude: 41.9000, longitude: 12.5000)))
        cities.append(City(cityName: "Tokyo", imageName: "Tokyo", cityLocation: CLLocation(latitude: 35.6833, longitude: 139.6833)))
        cities.append(City(cityName: "San Francisco", imageName: "SanFrancisco", cityLocation: CLLocation(latitude: 37.7833, longitude: -122.4167)))
        cities.append(City(cityName: "Paris", imageName: "Paris", cityLocation: CLLocation(latitude: 48.8567, longitude: 2.3508)))
        cities.append(City(cityName: "Rio De Janeiro", imageName: "RioDeJaneiro", cityLocation: CLLocation(latitude: -22.9068, longitude: -43.1729)))
        cities.append(City(cityName: "Hong Kong", imageName: "HongKong", cityLocation: CLLocation(latitude: 22.2783, longitude: 114.1747)))
        cities.append(City(cityName: "London", imageName: "London", cityLocation: CLLocation(latitude: 51.5072, longitude: 0.1275)))
        cities.append(City(cityName: "New York", imageName: "NewYork", cityLocation: CLLocation(latitude: 40.7127, longitude: -74.0059)))
        cities.append(City(cityName: "Moscow", imageName: "Moscow", cityLocation: CLLocation(latitude: 55.7500, longitude: 37.6167)))
        cities.append(City(cityName: "Sydney", imageName: "Sydney", cityLocation: CLLocation(latitude: -33.8650, longitude: 151.2094)))
        return cities
    }
    
    class func getCoverPhoto(cityName: String) -> UIImage? {
        let cities = availableCities()
        for city in cities {
            if (city.name == cityName) {
                return city.coverPhoto!
            }
        }
        return nil
    }
    
    class func paris() -> City {
        return City(cityName: "Paris", imageName: "Paris", cityLocation: CLLocation(latitude: 48.8567, longitude: 2.3508))
    }
}