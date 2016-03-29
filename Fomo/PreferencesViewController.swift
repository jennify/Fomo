//
// PreferencesViewController.swift
// ===============================


import UIKit


class PreferencesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let bannerView: UIView = UIView.newAutoLayoutView()
    let bannerImage: UIImageView = UIImageView.newAutoLayoutView()
    let preferencesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        return UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
    }()
    let doneButton: UIButton = UIButton.newAutoLayoutView()
    
    var preferences: [AttractionType] = AttractionType.availableCategories()

    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPreferencesCollectionView()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.fomoBackground()
        preferencesCollectionView.backgroundColor = UIColor.fomoBackground()
//        view.backgroundColor = UIColor(red: 186/255, green: 192/255, blue: 206/255, alpha: 1)
//        preferencesCollectionView.backgroundColor = UIColor(red: 186/255, green: 192/255, blue: 206/255, alpha: 1)
        bannerImage.image = UIImage(named: "pool")
        bannerImage.contentMode = .ScaleAspectFill

        doneButton.titleLabel?.font = UIFont.fomoH3()
        doneButton.setTitle("Save Preferences", forState: .Normal)
        doneButton.addTarget(self, action: "savePreferences", forControlEvents: .TouchUpInside)
        doneButton.addTarget(self, action: "buttonPress", forControlEvents: .TouchDown)
        doneButton.backgroundColor = UIColor.fomoHighlight()
        doneButton.layer.cornerRadius = 5
        
        view.addSubview(bannerView)
        bannerView.addSubview(bannerImage)
        view.addSubview(preferencesCollectionView)
        view.addSubview(doneButton)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            bannerView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            bannerView.autoPinEdgeToSuperviewEdge(.Left)
            bannerView.autoPinEdgeToSuperviewEdge(.Right)
            bannerView.autoSetDimension(.Height, toSize: 170)
            bannerImage.autoPinEdgesToSuperviewEdges()
            
            preferencesCollectionView.autoPinEdge(.Top, toEdge: .Bottom, ofView: bannerView)
            preferencesCollectionView.autoPinEdgeToSuperviewEdge(.Left)
            preferencesCollectionView.autoPinEdgeToSuperviewEdge(.Right)
            
            doneButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: preferencesCollectionView, withOffset: 20)
            doneButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30)
            doneButton.autoAlignAxisToSuperviewAxis(.Vertical)
            doneButton.contentEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 15)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setUpNavigationBar() {
        self.title = "Travel Preferences"
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
        cell.preferenceIcon.tintColor = cellColor
        cell.preferenceName.textColor = cellColor
        cell.layer.borderColor = cellColor.CGColor
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 20// cell.contentView.frame.height/2
        cell.contentView.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).CGColor
        cell.contentView.layer.borderColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1).CGColor
        cell.contentView.layer.borderWidth = 2
        return cell
    }

    func buttonPress() {
        doneButton.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
    
    func savePreferences() {
        doneButton.transform = CGAffineTransformIdentity
        
        // Navigate to browse view
        let fomoNavVC = self.navigationController! as UINavigationController
        fomoNavVC.popToRootViewControllerAnimated(false)
        let container = fomoNavVC.topViewController as! ContainerViewController
        container.onBrowsePressed(self)
    }
}

extension PreferencesViewController: PreferenceCellDelegate {
    func updateUserPreference(preference: AttractionType, cell: PreferenceCell) {
        let indexPath = preferencesCollectionView.indexPathForCell(cell)!
        preferences[indexPath.row] = preference
    }
}