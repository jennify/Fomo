//
//  TripViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }

    func setUpNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }
    

}
