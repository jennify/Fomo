//
//  AttractionViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class AttractionViewController: UIViewController {

    let attraction: Attraction = Attraction.generateTestInstance(City.generateTestInstance())

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = attraction.name
    }

}
