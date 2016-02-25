//
//  SecondViewController.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/8/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse

class SecondViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, FactualAPIDelegate {
    
    var menuToPass : [[MenuItem]]?
    var restList : [Restaurant] = []
    var user : User = User()
    var theRest : Restaurant?
    @IBOutlet weak var listOfRestrauntsTableView: UITableView!
    @IBOutlet weak var topScroller: UICollectionView!
    
// MARK: Parse
    func giveMenu(rest: Restaurant, indexPath : NSIndexPath) -> [[MenuItem]]{
        var menuToPass : [[MenuItem]] = [[], [], [], [], []]
        for var i = 0; i < 5; i++ {
            let query = MenuItem.query()
            query?.whereKey("owner", equalTo: rest)
            query?.whereKey("category", equalTo: i)
            
            do {
                let array = try query?.findObjects() as! [MenuItem]
                menuToPass[i] = array
                if i == 4 {
                    self.menuToPass = menuToPass
                    self.performSegueWithIdentifier("restToMen", sender: self.tableView(self.listOfRestrauntsTableView, cellForRowAtIndexPath: indexPath))
                    
                    break;
                }

            }  catch {
                print("Shit There Was An Error")
            }
        }
        return menuToPass
    }
    
    
    
    func queryForTable(parameter: Int?)
    {
        
        print("Searching for Restaurants...")
        let query = Restaurant.query()
        if parameter != nil {
            query?.whereKey("category", equalTo: parameter!)
        }
        query!.limit = 10
        query?.findObjectsInBackgroundWithBlock({ (rests, error) -> Void in
            if error == nil {
                self.restList = rests as! [Restaurant]
                
                
                self.listOfRestrauntsTableView.reloadData()
            }
        })
        
    }
    
// MARK: TableView Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestCell", forIndexPath: indexPath) as! RestaurantCell
        cell.setUpCell(restList[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.xyz(restList[0])
        self.giveMenu(restList[indexPath.row], indexPath: indexPath)
    }
    
    
    
// MARK: CollectionView Functions
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TopScroller", forIndexPath: indexPath) as! TopScrollCellCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.tagNum = 2
        cell.setUpCell(indexPath.row)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("alright you chose")
        queryForTable(indexPath.row + 1)
        return true
    }

// MARK: Basic VC Functions
    
    override func viewDidLoad() {
        let image = UIImage(named: "Fries-1.png")
        self.listOfRestrauntsTableView.backgroundColor = UIColor(patternImage: image!)
        self.listOfRestrauntsTableView.dataSource = self
        self.user = PFUser.currentUser() as! User
        queryForTable(nil)
        self.listOfRestrauntsTableView.delegate = self
        self.topScroller.delegate = self
        self.topScroller.dataSource = self
        self.topScroller.backgroundColor = UIColor.clearColor()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func xyz(rest: Restaurant) {
        let thisItem = MenuItem()
        thisItem.name = "Cake"
        thisItem.owner = self.restList[0]
        thisItem.saveInBackgroundWithBlock { (yes, err) -> Void in
            let menu = Menu()
            menu.items.append(thisItem)
            menu.owner = self.restList[0]
            menu.saveInBackground()
        }
    }

    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "restToMen" {
            
            let cell = sender as! RestaurantCell
            let toVC = segue.destinationViewController as! MenuCollectionViewController
            toVC.theRestaurant = cell.theRest;
            toVC.theMenu = menuToPass!
        }
    }
}

