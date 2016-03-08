//
//  PreferencesViewController.swift
//  Fomo
//
//  Created by Christian Deonier on 3/5/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout

class PreferencesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let preferencesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        return UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
    }()
    var didSetupConstraints = false
    
    let preferences: [AttractionType] = [AttractionType.generateTestInstance()]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPreferencesCollectionView()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = UIView()
        
        preferencesCollectionView.backgroundColor = UIColor.greenColor()
        
        view.addSubview(preferencesCollectionView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            preferencesCollectionView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBarHidden = true
        navigationItem.title = "Preferences"
    }
    
    //# MARK: Preferences Collection View
    
    func setUpPreferencesCollectionView() {
        preferencesCollectionView.delegate = self
        preferencesCollectionView.dataSource = self
        preferencesCollectionView.registerClass(PreferenceCell.self, forCellWithReuseIdentifier: "CodePath.Fomo.PreferenceCell")
        preferencesCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return preferences.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CodePath.Fomo.PreferenceCell", forIndexPath: indexPath) as! PreferenceCell
        configurePreferenceCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configurePreferenceCell(cell: PreferenceCell, indexPath: NSIndexPath) {
        let preference = preferences[indexPath.row]
        cell.preferenceName.text = preference.name
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        displayTodo("Set the preference")
    }
    
    func displayTodo(todo: String) {
        let alertController = UIAlertController(title: "Fomo", message:"TODO: \(todo)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
