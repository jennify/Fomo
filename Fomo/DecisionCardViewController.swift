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
    var currentAttraction: Attraction?
    var likeButton: UIButton = UIButton.newAutoLayoutView()
    var dislikeButton: UIButton = UIButton.newAutoLayoutView()
    
    // State
    var didSetConstraints = false
    var voteState: [Int]!
    
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
        self.voteState = []
        Recommendation.getRecommendations() {
            (response: Recommendation?, error: NSError?) in
            if error == nil && response != nil {
                self.recommendations = response!
                self.countOfCards = self.recommendations!.attractions?.count ?? 0
                
            } else {
                print(error)
                self.recommendations = Recommendation.generateTestInstance()
            }
            for _ in 1...self.countOfCards {
                self.voteState.append(-1)
            }
            self.collectionView?.reloadData()
            
        }
        
        
        completeButton.setImage(UIImage(named: "smiling"), forState: .Normal)
        completeButton.setTitle(" Check out itinerary.", forState: .Normal)
        completeButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        completeButton.layer.zPosition = -1
        completeButton.addTarget(self, action: "goToItinerary", forControlEvents: UIControlEvents.TouchUpInside)
        
        likeButton.setImage(UIImage(named: "like"), forState: .Normal)
        likeButton.addTarget(self, action: "onLike", forControlEvents: .TouchUpInside)
        likeButton.tintColor = UIColor.greenColor()
        
        dislikeButton.setImage(UIImage(named: "dislike"), forState: .Normal)
        dislikeButton.addTarget(self, action: "onDislike", forControlEvents: .TouchUpInside)
        dislikeButton.tintColor = UIColor.redColor()
        
        self.view.addSubview(completeButton)
        self.view.addSubview(likeButton)
        self.view.addSubview(dislikeButton)
        setUpNavigationBar()
    }
    
    func goToItinerary() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func updateViewConstraints() {
        if !didSetConstraints {
            let buttons: NSArray = [dislikeButton, likeButton]
            buttons.autoDistributeViewsAlongAxis(.Horizontal, alignedTo: .Horizontal, withFixedSize: 48, insetSpacing: true)
            buttons[0].autoAlignAxis(.Horizontal, toSameAxisOfView: self.view, withOffset: cardHeight/2 + 50)
            
            completeButton.autoCenterInSuperview()
            
            didSetConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    var cardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.fomoBackground()
        
        //set animation speed
        setAnimationSpeed(0.85)
        
        //set size of cards
        cardHeight = 2*self.view.bounds.height/4
        let size = CGSizeMake(view.bounds.width - 40, cardHeight)
        setCardSize(size)
        collectionView?.registerClass(DecisionCardCell.self, forCellWithReuseIdentifier: "CardIdentifier")
        
        cardStackDelegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "onTap:")
        collectionView?.addGestureRecognizer(tapGesture)
        
        //configuration of stacks
        layout.topStackMaximumSize = 4
        layout.bottomStackMaximumSize = 30
        layout.bottomStackCardHeight = 100
        setUpNavigationBar()
        
    }
    
    
    func setUpNavigationBar() {
        self.title = "Explore"
    }
    
    func onTap(gesture: UITapGestureRecognizer) {
        let carouselViewController = CarouselViewController()
        carouselViewController.imagePaths = currentAttraction!.imageUrls
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        
        carouselViewController.view.frame = self.view.bounds
        carouselViewController.view.backgroundColor = UIColor.clearColor()
        carouselViewController.view.insertSubview(blurEffectView, atIndex: 0)
        carouselViewController.modalPresentationStyle = .OverCurrentContext
        carouselViewController.modalTransitionStyle = .CrossDissolve
        
        presentViewController(carouselViewController, animated: true, completion: nil)
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
        
        if self.recommendations == nil {
            return cell
        }
        cell.attraction = self.recommendations?.attractions?[indexPath.row]
        cell.backgroundColor = UIColor.fomoCardBG()
        cell.initViews()
        cell.vote = 0
        // We need to know what the current attraction is displayed, so we can pass it to the photo carousel if there's a tap
        currentAttraction = cell.attraction
        
        return cell
        
    }
    
    func onLike() {
        moveCardDown()
    }
    
    func onDislike() {
        moveCardDown()
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
        let indexPath = NSIndexPath(forRow: cardIndex, inSection:0)
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! DecisionCardCell
        var voteNum: Int = 0
        if cell.vote != nil {
            voteNum = cell.vote!
        }
        self.voteState[cardIndex] = voteNum
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
    
    var likeImage: UIImageView = UIImageView.newAutoLayoutView()
    var descView: UIView = UIView.newAutoLayoutView()
    
    var vote: Int?
    
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
        blurView.contentView.alpha = 0.0
    }
    
    func showBlurView() {
        blurView.contentView.alpha = 1.0
    }
    
    func initViews() {
        layer.cornerRadius = 12
        clipsToBounds = false
        locationImage.clipsToBounds = true
        self.clipsToBounds = true
        
        voteSmileImageView.image = UIImage(named: "smile_neutral")
        
        blurView.effect = UIBlurEffect(style: .ExtraLight)
        blurView.alpha = 0.8
        
        if attraction != nil {
            if attraction!.imageUrls?.count == 0 {
                locationImage.image = UIImage(named: "smiling")
            } else {
                locationImage.setImageWithURL(NSURL(string: (attraction!.imageUrls!.first)!)!)
            }
            nameLabel.text = attraction?.name
            nameLabel.font = UIFont.fomoH1()
            nameLabel.numberOfLines = 0
            nameLabel.sizeToFit()
            
            typeLabel.text = attraction?.getTypeString()
            typeLabel.font = UIFont.fomoParagraph()
            typeLabel.textColor = UIColor.darkGrayColor()
            typeLabel.numberOfLines = 0
            typeLabel.sizeToFit()
            
            var ratingText = ""
            if attraction!.rating == nil {
                ratingText = "?"
            } else {
                ratingText = "\(attraction!.rating!)"
            }

            ratingLabel.text = ratingText
            ratingLabel.font = UIFont.fomoH1()
            ratingLabel.textColor = UIColor.whiteColor()
            
            ratingView.backgroundColor = UIColor.fomoHighlight()
            ratingView.layer.cornerRadius = 5
            ratingView.clipsToBounds = true
            
            descView.backgroundColor = UIColor.clearColor()
        }
        
        descView.addSubview(blurView)
//        descView.addSubview(voteSmileImageView)
        ratingView.addSubview(ratingLabel)
        descView.addSubview(ratingView)
        descView.addSubview(nameLabel)
        descView.addSubview(typeLabel)
        
        locationImage.addSubview(descView)
        self.addSubview(locationImage)
        
        
    }
    
    
    func updateViewConstraints() {
//        voteSmileImageView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 8)
//        voteSmileImageView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
//        voteSmileImageView.autoSetDimension(.Width, toSize: 30)
//        voteSmileImageView.autoSetDimension(.Height, toSize: 30)
        
        locationImage.autoPinEdgesToSuperviewEdges()
        
        blurView.autoPinEdgesToSuperviewEdges()
        
        ratingView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
        ratingView.autoPinEdge(.Top, toEdge: .Top, ofView: descView, withOffset: 8)
        ratingView.autoSetDimension(.Width, toSize: 40)
        ratingView.autoSetDimension(.Height, toSize: 40)
        
        ratingLabel.autoCenterInSuperview()
        
        nameLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
        nameLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
        nameLabel.autoPinEdge(.Right, toEdge: .Left, ofView: ratingView, withOffset: -8)
        
        typeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: nameLabel)
        typeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel, withOffset: 8)
        typeLabel.autoPinEdge(.Right, toEdge: .Left, ofView: ratingView, withOffset: -8)
        
        descView.autoPinEdgeToSuperviewEdge(.Leading)
        descView.autoPinEdgeToSuperviewEdge(.Trailing)
        descView.autoPinEdgeToSuperviewEdge(.Bottom)
        descView.autoSetDimension(.Height, toSize: 70)
        
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
            updateVote(1)
        } else if rotation > 0 {
            smileImageName = "smile_face_1"
            updateVote(1)
        } else if rotation < -15 {
            smileImageName = "smile_rotten_2"
            updateVote(-1)
        } else if rotation < 0 {
            smileImageName = "smile_rotten_1"
            updateVote(-1)
        }
        voteSmileImageView.image = UIImage(named: smileImageName)
    }
    
    func updateVote(decision: Int) {
        if decision != 0 {
            vote = decision
        }
    }
    
    
}
