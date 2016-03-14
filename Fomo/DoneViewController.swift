//
//  DoneViewController.swift
//  Fomo
//
//  Created by Christian Deonier on 3/13/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {
    
    let coverPhoto: UIImageView = UIImageView.newAutoLayoutView()
    let travellersView: TravellersView = TravellersView.newAutoLayoutView()
    let tableView: UITableView = UITableView.newAutoLayoutView()
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Your Trip"
    }
    
    override func loadView() {
        view = UIView()
        
        coverPhoto.backgroundColor = UIColor.redColor()
        travellersView.backgroundColor = UIColor.greenColor()
        tableView.backgroundColor = UIColor.blueColor()
        
        view.addSubview(coverPhoto)
        view.addSubview(travellersView)
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            coverPhoto.autoSetDimension(.Height, toSize: 200)
            coverPhoto.autoPinEdgeToSuperviewEdge(.Top)
            coverPhoto.autoPinEdgeToSuperviewEdge(.Left)
            coverPhoto.autoPinEdgeToSuperviewEdge(.Right)
            
            travellersView.autoSetDimension(.Height, toSize: 70.0)
            travellersView.autoPinEdgeToSuperviewEdge(.Left)
            travellersView.autoPinEdgeToSuperviewEdge(.Right)
            travellersView.autoPinEdge(.Top, toEdge: .Bottom, ofView: coverPhoto)
            
            tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: travellersView)
            tableView.autoPinEdgeToSuperviewEdge(.Left)
            tableView.autoPinEdgeToSuperviewEdge(.Right)
            tableView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
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
