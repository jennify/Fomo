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
    var containerView: UIView!
    var buttonSwitcher: UIButton!
    
    var city: City = City.paris()
    var attractions: [Attraction] = Attraction.generateTestInstances()
    
    var mapInFront: Bool = true
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for hotel in Attraction.parisHotels() {
            attractions.append(hotel)
        }
        
        setUpContainerView()
        setUpPanoView()
        setUpMapView()
        setUpMarkers()
        setUpButtonSwitcher()
        setUpTransitions()
    }
    
    func setUpContainerView() {
        containerView = UIView()
        view.addSubview(containerView)
    }
    
    func setUpMapView() {
        let lat = city.location!.coordinate.latitude
        let lng = city.location!.coordinate.longitude
        let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude:lng, zoom:12)
        mapView = GMSMapView.mapWithFrame(.zero, camera: camera)
        mapView.delegate = self
        containerView.addSubview(mapView)
    }
    
    func setUpPanoView() {
        let firstAttraction = attractions.first!
        let panoramaNear = getAttractionPosition(firstAttraction)
        panoView = GMSPanoramaView.panoramaWithFrame(.zero, nearCoordinate:panoramaNear)
        containerView.addSubview(panoView)
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
        if (mapInFront) {
            mapInFront = false
            UIView.transitionFromView(mapView, toView: panoView, duration: 1, options: .TransitionCrossDissolve, completion: { (Bool) in
                self.containerView.addSubview(self.mapView)
                self.containerView.sendSubviewToBack(self.mapView)
                self.didSetupConstraints = false
                self.updateViewConstraints()
            });
        } else {
            mapInFront = true
            UIView.transitionFromView(panoView, toView: mapView, duration: 1, options: .TransitionCrossDissolve, completion: { (Bool) in
                self.containerView.addSubview(self.panoView)
                self.containerView.sendSubviewToBack(self.panoView)
                self.didSetupConstraints = false
                self.updateViewConstraints()
            });
        }
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            mapView.configureForAutoLayout()
            panoView.configureForAutoLayout()
            containerView.configureForAutoLayout()
            buttonSwitcher.configureForAutoLayout()
            
            mapView.autoPinEdgesToSuperviewEdges()
            panoView.autoPinEdgesToSuperviewEdges()
            containerView.autoPinEdgesToSuperviewEdges()
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
