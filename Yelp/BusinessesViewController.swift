//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate, UISearchBarDelegate {

    var businesses: [Business]!
    var filters = [String : AnyObject]()
    lazy var searchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
//        })
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        /*
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
        searchBusisness()
        
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        
        navigationItem.titleView = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil{
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    
    //Search Bar
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        businesses.removeAll(keepCapacity: false)
        tableView.reloadData()
        searchBusisness()
        searchBar.resignFirstResponder()
    }
    
    func searchBusisness() {
        
        var searchString: String?
        
        searchString = searchBar.text ?? ""
        /*
        let sort = filters["sort"] as? Int
        let categories = self.filters["categories"] as? [String]
        let deal = self.filters["deal"] as? Bool
        let radius = self.filters["radius"] as! Float?
        let offset = businesses.count
        */
        let categories = ["asianfusion", "burgers"]
        
        
        Business.searchWithTerm(searchString!, sort: .Distance, categories: categories, deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
        /*
        Business.searchWithTerm(term, sort: sort, categories: categories, deals: deal, radius: radius, offset: offset) { (result: Result!, error: NSError!) -> Void in
            
            if result != nil {
                self.totalResult = result.total!
                
                if offset < result.total {
                    for b in result.businesses {
                        self.businesses.append(b)
                    }
                }
                self.tableView.reloadData()
                self.createMarkers()
                //println("total: \(result.total)")
            } else {
                self.totalResult = 0
            }
            
            self.setTableViewVisible()
        }
*/
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        Business.searchWithTerm("Restautants", sort: nil, categories: categories, deals: nil) {( businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
}
