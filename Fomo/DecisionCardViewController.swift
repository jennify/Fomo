//
//  DecisionCardViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 3/16/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import TisprCardStack

class DecisionCardViewController: TisprCardStackViewController, TisprCardStackViewControllerDelegate {
    let completeButton: UIButton = UIButton.newAutoLayoutView()
    var recommendations: Recommendation?
    
    private let colors = [UIColor(red: 45.0/255.0, green: 62.0/255.0, blue: 79.0/255.0, alpha: 1.0),
        UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0),
        UIColor(red: 141.0/255.0, green: 72.0/255.0, blue: 171.0/255.0, alpha: 1.0),
        UIColor(red: 241.0/255.0, green: 155.0/255.0, blue: 44.0/255.0, alpha: 1.0),
        UIColor(red: 234.0/255.0, green: 78.0/255.0, blue: 131.0/255.0, alpha: 1.0),
        UIColor(red: 80.0/255.0, green: 170.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    ]
    
    private var countOfCards: Int = 6
    
    required override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        initViews()
        updateViewConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
        updateViewConstraints()
    }
    
    required init() {
        let layout = TisprCardStackViewLayout()
        super.init(collectionViewLayout: layout)
        initViews()
        updateViewConstraints()
    }
    
    func initViews() {
        recommendations = Recommendation.generateTestInstance()
        self.countOfCards = recommendations!.attractions!.count
        
        completeButton.setImage(UIImage(named: "car"), forState: .Normal)
        completeButton.setTitle("Success!", forState: .Normal)
        completeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        completeButton.contentVerticalAlignment = .Bottom
        completeButton.contentHorizontalAlignment = .Left
        completeButton.layer.zPosition = -1
        self.view.addSubview(completeButton)
    }
    
    override func updateViewConstraints() {
        completeButton.autoCenterInSuperview()
        
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        //set animation speed
        setAnimationSpeed(0.85)
        
        //set size of cards
        let size = CGSizeMake(view.bounds.width - 40, 2*view.bounds.height/3)
        setCardSize(size)
        collectionView?.registerClass(DecisionCardCell.self, forCellWithReuseIdentifier: "CardIdentifier")
        
        cardStackDelegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "onTap:")
        collectionView?.addGestureRecognizer(tapGesture)
        
        //configuration of stacks
        layout.topStackMaximumSize = 4
        layout.bottomStackMaximumSize = 30
        layout.bottomStackCardHeight = 45
    }
    
    
    func onTap(gesture: UITapGestureRecognizer) {
        displayTodo("Christian does his magic")
    }
    
    func displayTodo(todo: String) {
        let alertController = UIAlertController(title: "Fomo", message:"TODO: \(todo)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func numberOfCards() -> Int {
        return countOfCards
    }
    
    override func card(collectionView: UICollectionView, cardForItemAtIndexPath indexPath: NSIndexPath) -> TisprCardStackViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardIdentifier", forIndexPath: indexPath) as! DecisionCardCell
        
        let numAttractions = self.recommendations?.attractions?.count
        // Fix hack to actually load all the attractions.
        cell.attraction = self.recommendations?.attractions?[indexPath.item % numAttractions!]
        cell.backgroundColor = UIColor.fomoPeriwinkle()
        // No longer using the cute colors from the library :(
        //colors[indexPath.item % colors.count]
        cell.initViews()
        cell.hideBlurView()
        
        
        return cell
        
    }

//method to add new card
//    @IBAction func addNewCards(sender: AnyObject) {
//        countOfCards++
//        newCardWasAdded()
//    }
//    @IBAction func moveUP(sender: AnyObject) {
//        moveCardUp()
//    }
//    
//    @IBAction func moveCardDown(sender: AnyObject) {
//        moveCardDown()
//    }

    func cardDidChangeState(cardIndex: Int) {
        // TODO(jlee): Super janky way of hiding and showing the finish state.
        if cardIndex == self.numberOfCards() {
            completeButton.layer.zPosition = 0
        } else {
            completeButton.layer.zPosition = -1
        }
    }
}

class DecisionCardCell: TisprCardStackViewCell {
    var attraction: Attraction?
    var voteSmileImageView: UIImageView = UIImageView.newAutoLayoutView()
    var locationImage: UIImageView = UIImageView.newAutoLayoutView()
    var blurView: UIVisualEffectView = UIVisualEffectView.newAutoLayoutView()
    var nameLabel: UILabel = UILabel.newAutoLayoutView()
    var typeLabel: UILabel = UILabel.newAutoLayoutView()
    var ratingView: UIView = UIView.newAutoLayoutView()
    var ratingLabel: UILabel = UILabel.newAutoLayoutView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
        updateViewConstraints()
        
    }
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        initViews()
        updateViewConstraints()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        updateViewConstraints()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
        updateViewConstraints()
            }
    
    override var center: CGPoint {
        didSet {
            updateSmileVote()
        }
    }
    
    func hideBlurView() {
        blurView.alpha = 0.0
    }
    
    func showBlurView() {
        blurView.alpha = 1.0
    }
    
    func initViews() {
        layer.cornerRadius = 12
        clipsToBounds = false
        locationImage.clipsToBounds = true
        self.clipsToBounds = true
        
        voteSmileImageView.image = UIImage(named: "smile_neutral")
        blurView.effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        if attraction != nil {
            locationImage.setImageWithURL(NSURL(string: (attraction!.imageUrls!.first)!)!)
            
            nameLabel.text = attraction?.name
            nameLabel.font = UIFont.fomoH1()
            nameLabel.sizeToFit()
            nameLabel.numberOfLines = 0
            
            typeLabel.text = attraction?.getTypeString()
            typeLabel.font = UIFont.fomoParagraph()
            typeLabel.textColor = UIColor.darkGrayColor()
            
            ratingLabel.text = "\(attraction!.rating!)"
            ratingLabel.font = UIFont.fomoH1()
            ratingLabel.textColor = UIColor.whiteColor()
            
            ratingView.backgroundColor = UIColor.fomoBlue()
            ratingView.layer.cornerRadius = 5
            ratingView.clipsToBounds = true
            
        }
        
        self.addSubview(blurView)
        self.addSubview(voteSmileImageView)
        self.addSubview(locationImage)
        ratingView.addSubview(ratingLabel)
        self.addSubview(ratingView)
        self.addSubview(nameLabel)
        self.addSubview(typeLabel)
        
    }
    
    
    func updateViewConstraints() {
        voteSmileImageView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 8)
        voteSmileImageView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
        voteSmileImageView.autoSetDimension(.Width, toSize: 30)
        voteSmileImageView.autoSetDimension(.Height, toSize: 30)
        
        locationImage.autoPinEdgeToSuperviewEdge(.Top)
        locationImage.autoPinEdgeToSuperviewEdge(.Leading)
        locationImage.autoPinEdgeToSuperviewEdge(.Trailing)
        locationImage.autoSetDimension(.Height, toSize: self.frame.height/4 * 3)
        
        blurView.autoPinEdgeToSuperviewEdge(.Top)
        blurView.autoPinEdgeToSuperviewEdge(.Leading)
        blurView.autoPinEdgeToSuperviewEdge(.Trailing)
        blurView.autoSetDimension(.Height, toSize: self.frame.height/4 * 3)
        
        ratingView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
        ratingView.autoPinEdge(.Top, toEdge: .Bottom, ofView: locationImage, withOffset: 8)
        ratingView.autoSetDimension(.Width, toSize: 40)
        ratingView.autoSetDimension(.Height, toSize: 40)
        
        ratingLabel.autoCenterInSuperview()
        
        nameLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
        nameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: locationImage, withOffset: 8)
        
        typeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: nameLabel)
        typeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel, withOffset: 8)
        
    }
    
    
    override internal func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        updateSmileVote()
    }
    
    func updateSmileVote() {
        let rotation = atan2(transform.b, transform.a) * 100
        var smileImageName = "smile_neutral"
        
        if rotation > 15 {
            smileImageName = "smile_face_2"
        } else if rotation > 0 {
            smileImageName = "smile_face_1"
        } else if rotation < -15 {
            smileImageName = "smile_rotten_2"
        } else if rotation < 0 {
            smileImageName = "smile_rotten_1"
        }
        voteSmileImageView.image = UIImage(named: smileImageName)
    }
    
    
}
