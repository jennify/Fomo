//
// PreferencesViewController.swift
// ===============================


import UIKit


class PreferencesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let preferencesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        return UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
    }()
    
    var preferences: [AttractionType] = AttractionType.availableCategories()

    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPreferencesCollectionView()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = UIView()

        preferencesCollectionView.backgroundColor = UIColor.fomoBackground()

        view.addSubview(preferencesCollectionView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            preferencesCollectionView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            preferencesCollectionView.autoPinEdgeToSuperviewEdge(.Left)
            preferencesCollectionView.autoPinEdgeToSuperviewEdge(.Right)
            preferencesCollectionView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Travel Preferences"
    }
    
    // Preferences Collection View
    
    func setUpPreferencesCollectionView() {
        preferencesCollectionView.delegate = self
        preferencesCollectionView.dataSource = self
        preferencesCollectionView.registerClass(PreferenceCell.self, forCellWithReuseIdentifier: "CodePath.Fomo.PreferenceCell")
        preferencesCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let totalwidth = collectionView.bounds.size.width - 40;
        let numberOfCellsPerRow = 3
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        return CGSizeMake(dimensions, dimensions)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return preferences.count
    }
    
    func colorForIndexPath(indexPath: NSIndexPath) -> UIColor {
        let hueValue: CGFloat = CGFloat(indexPath.row) / CGFloat(preferences.count)
        return UIColor(hue: hueValue, saturation: 0.5, brightness: 0.9, alpha: 1)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CodePath.Fomo.PreferenceCell", forIndexPath: indexPath) as! PreferenceCell
        cell.attractionType = preferences[indexPath.row]
        cell.delegate = self
        let cellColor = colorForIndexPath(indexPath)
        cell.preferenceIcon.image = cell.preferenceIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.preferenceIcon.tintColor = UIColor.fomoLight()
        cell.preferenceName.textColor = UIColor.fomoLight()
        cell.layer.borderColor = cellColor.CGColor
        cell.contentView.layer.borderColor = cellColor.CGColor
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = cell.contentView.frame.height/2
        cell.contentView.backgroundColor = cellColor


        return cell
    }
}

extension PreferencesViewController: PreferenceCellDelegate {
    func updateUserPreference(preference: AttractionType, cell: PreferenceCell) {
        let indexPath = preferencesCollectionView.indexPathForCell(cell)!
        preferences[indexPath.row] = preference
    }
}