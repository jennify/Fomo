//
//  DoneViewController.swift
// ============================


import UIKit
import SAConfettiView


class DoneViewController: UIViewController {
    
    let coverPhoto: UIImageView = UIImageView.newAutoLayoutView()
    let travellersView: TravellersView = TravellersView.newAutoLayoutView()
    let tableView: UITableView = UITableView.newAutoLayoutView()
    let confettiView: SAConfettiView = SAConfettiView.newAutoLayoutView()
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        confettiView.startConfetti()

        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title =  "Your Trip"
    }
    
    override func loadView() {
        view = UIView()
        
        coverPhoto.backgroundColor = UIColor.fomoWhite()
        travellersView.backgroundColor = UIColor.fomoPeriwinkle()
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        view.addSubview(coverPhoto)
        view.addSubview(travellersView)
        view.addSubview(tableView)
        view.addSubview(confettiView)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            coverPhoto.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            coverPhoto.autoSetDimension(.Height, toSize: 200)
            coverPhoto.autoPinEdgeToSuperviewEdge(.Left)
            coverPhoto.autoPinEdgeToSuperviewEdge(.Right)
            
            travellersView.autoSetDimension(.Height, toSize: 70)
            travellersView.autoPinEdgeToSuperviewEdge(.Left)
            travellersView.autoPinEdgeToSuperviewEdge(.Right)
            travellersView.autoPinEdge(.Top, toEdge: .Bottom, ofView: coverPhoto)
            
            tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: travellersView)
            tableView.autoPinEdgeToSuperviewEdge(.Left)
            tableView.autoPinEdgeToSuperviewEdge(.Right)
            tableView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            confettiView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}
