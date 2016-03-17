//
//  CityViewController.swift
// ============================


import UIKit


class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let searchBar: UISearchBar = UISearchBar.newAutoLayoutView()
    let tableView: UITableView = UITableView.newAutoLayoutView()
    let cities: [City] = City.availableCities()
    var filteredCities: [City] = []
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCities = cities
        
        setUpTableView()
        setUpSearchBar()
        setUpNavigationBar()
    }

    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(CityCell.self, forCellReuseIdentifier: "CodePath.Fomo.CityCell")
        tableView.backgroundColor = UIColor.fomoSand()
    }
    
    func setUpSearchBar() {
        searchBar.placeholder = "Where to?"
        searchBar.delegate = self
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Destination"
    }
    
    override func loadView() {
        view = UIView()
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            searchBar.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            searchBar.autoPinEdgeToSuperviewEdge(.Left)
            searchBar.autoPinEdgeToSuperviewEdge(.Right)
            
            tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBar)
            tableView.autoPinEdgeToSuperviewEdge(.Left)
            tableView.autoPinEdgeToSuperviewEdge(.Right)
            tableView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodePath.Fomo.CityCell", forIndexPath: indexPath) as! CityCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let city = cities[indexPath.row]
        let tripViewController = TripViewController()
        tripViewController.city = city
        
        self.navigationController?.pushViewController(tripViewController, animated: true)
    }
    
    func configureCell(cell: CityCell, indexPath: NSIndexPath) {
        let city = filteredCities[indexPath.row]
        cell.cityName.text = city.name
        cell.cityName.font = UIFont.fomoBoldest(20)
        cell.cityImageView.image = city.coverPhoto
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCities = cities
        
        if (!searchText.isEmpty) {
            filteredCities = filteredCities.filter({ (city) -> Bool in
                return city.name!.containsString(searchText)
            });
        }

        tableView.reloadData()
    }
}