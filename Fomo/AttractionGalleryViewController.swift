//
//  AttractionGalleryViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class AttractionGalleryViewController: UIViewController {

    let attraction: Attraction = Attraction.generateTestInstance(City.generateTestInstance())

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }

    func setUpNavigationBar() {
        self.navigationController?.navigationBarHidden = true
        navigationItem.title = attraction.name
    }


}
