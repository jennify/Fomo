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
    
    var attractions: [Attraction] = []
    
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
        let camera = GMSCameraPosition.cameraWithLatitude(-33.868, longitude:151.2086, zoom:6)
        mapView = GMSMapView.mapWithFrame(.zero, camera: camera)
        mapView.delegate = self
        mapView.hidden = true
        view.addSubview(mapView)
    }
    
    func setUpPanoView() {
        let panoramaNear = CLLocationCoordinate2DMake(50.059139, -122.958391)
        panoView = GMSPanoramaView.panoramaWithFrame(.zero, nearCoordinate:panoramaNear)
        view.addSubview(panoView)
    }
    
    func setUpMarkers() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.snippet = "Hello World";
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
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
        print("Did tap marker")
        //mapView.selectedMarker = marker
        return false
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
