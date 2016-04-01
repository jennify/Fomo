//
//  MapViewController.swift
//  Fomo
//
//  Created by Christian Deonier on 3/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, GMSPanoramaViewDelegate {
    
    var mapView: GMSMapView!
    var panoView: GMSPanoramaView!
    var buttonSwitcher: UIButton!
    
    var city: City = City.paris()
    var attractions: [Attraction] = Attraction.generateTestInstances()
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMapView()
        setUpPanoView()
        setUpMarkers()
        setUpButtonSwitcher()
        setUpTransitions()
    }
    
    func setUpMapView() {
        let lat = city.location!.coordinate.latitude
        let lng = city.location!.coordinate.longitude
        let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude:lng, zoom:12)
        mapView = GMSMapView.mapWithFrame(.zero, camera: camera)
        mapView.delegate = self
        mapView.hidden = false
        view.addSubview(mapView)
    }
    
    func setUpPanoView() {
        let firstAttraction = attractions.first!
        let panoramaNear = getAttractionPosition(firstAttraction)
        panoView = GMSPanoramaView.panoramaWithFrame(.zero, nearCoordinate:panoramaNear)
        panoView.hidden = true
        view.addSubview(panoView)
    }
    
    func setUpMarkers() {
        for attraction in attractions {
            let attractionType = attraction.types!.first!
            
            let icon = attractionType.icon
            let scaledIcon = scaleImage(icon!)
            let finalIcon = imageWithColor(scaledIcon, color: attractionType.color!)
            
            let marker = GMSMarker()
            marker.userData = attraction
            marker.icon = finalIcon
            marker.position = getAttractionPosition(attraction)
            marker.snippet = attraction.name!
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = mapView;
        }
    }
    
    func setUpButtonSwitcher() {
        buttonSwitcher = UIButton(type: .System)
        buttonSwitcher.backgroundColor = UIColor.greenColor()
        buttonSwitcher.setTitle("Switch", forState: .Normal)
        buttonSwitcher.addTarget(self, action: #selector(MapViewController.swapMapAndPanoView), forControlEvents: .TouchUpInside)
        
        view.addSubview(buttonSwitcher)
    }
    
    func setUpTransitions() {
        
    }
    
    func getAttractionPosition(attraction: Attraction) -> CLLocationCoordinate2D {
        let lat = attraction.location!.coordinate.latitude
        let lng = attraction.location!.coordinate.longitude
        return CLLocationCoordinate2DMake(lat, lng)
    }
    
    func swapMapAndPanoView() {
        if (mapView.hidden) {
            mapView.hidden = false
            panoView.hidden = true
        } else {
            mapView.hidden = true
            panoView.hidden = false
        }
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            mapView.configureForAutoLayout()
            panoView.configureForAutoLayout()
            buttonSwitcher.configureForAutoLayout()
            
            mapView.autoPinEdgesToSuperviewEdges()
            panoView.autoPinEdgesToSuperviewEdges()
            buttonSwitcher.autoSetDimensionsToSize(CGSize(width: 50, height: 50))
            buttonSwitcher.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            buttonSwitcher.autoPinEdgeToSuperviewEdge(.Top, withInset: 75)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        let attraction = marker.userData as! Attraction
        panoView.moveNearCoordinate(getAttractionPosition(attraction))
        return false
    }
    
//    func scaleImage(image: UIImage, color: UIColor) -> UIImage {
//        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.3, 0.3))
//        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
//        
//        UIGraphicsBeginImageContextWithOptions(size, false, scale)
//        
//        image.drawInRect(CGRect(origin: CGPointZero, size: size))
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return scaledImage
//    }
    
    func scaleImage(image: UIImage) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.3, 0.3))
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    
    //Merge with above if time
    func imageWithColor(image: UIImage, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, image.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, image.size.width, image.size.height) as CGRect
        CGContextClipToMask(context, rect, image.CGImage)
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
