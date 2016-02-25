//
//  MenuCollectionViewController.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/28/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse

private let reuseIdentifier = "MenuCell"
private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

class MenuCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var theRestaurant : Restaurant?
    var theMenu : [[MenuItem]]?
    var chosenItems: [MenuItem] = []
    var user : User?
    var total : Double = 0
    var indexCounter = 0;
    
    var topDel : TopScrollDelegate = TopScrollDelegate()
    
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var mainMenu: UICollectionView!
    @IBOutlet weak var topScroller: UICollectionView!
    
    
    @IBAction func backToSelect(sender: AnyObject) {
        performSegueWithIdentifier("backToRest", sender: self)
    }
    
    
    func updateTotalLabel() {
        if total < 0.01 { total = 0}
        self.totalLabel.text = "Total: $\(total)"
    }
    
    func frameChanger() {
        self.mainMenu.layer.cornerRadius = 10
    }
    
    func updateIndexes(after : Int) {
        for var i = 0; i < chosenItems.count; i++ {
            if i > after {
                chosenItems[i].indexSpot!--
            } else if i == after {
                chosenItems[i].indexSpot = nil
            }
        }
        
        self.chosenItems.removeAtIndex(after)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameChanger()
        
        self.mainMenu.delegate = self
        self.topScroller.delegate = self.topDel
        self.mainMenu.dataSource = self
        self.topScroller.dataSource = self.topDel
        
        topDel.masterVC = self
        
        
        user = PFUser.currentUser() as? User
        self.mainMenu?.clearsContextBeforeDrawing = false
        self.mainMenu?.allowsMultipleSelection = true
        let image = UIImage(named: "Fries-1")
        
        self.mainMenu!.backgroundColor = UIColor(patternImage: image!)
        self.topScroller.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(collectionView.restorationIdentifier)
        return theMenu!.count;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return theMenu![section].count;
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MenuItemCell
        
        let theItem = theMenu![indexPath.section][indexPath.row]
        indexCounter++
        cell.item = theItem
        cell.nameLabel.text = theItem.name
        cell.priceLabel.text = "$\(theItem.price)0"
        cell.backgroundColor = UIColor.clearColor()
        return cell
        
    }
    
    
    
    
    //SelectedCelll
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let cell = self.mainMenu.cellForItemAtIndexPath(indexPath) as! MenuItemCell
        
        if !cell.selected {                                           //selected
            cell.selectedForBuy = true
            self.total = total + (cell.item?.price)!
            self.chosenItems.append(cell.item!)
            cell.item?.indexSpot = self.chosenItems.count - 1
            cell.backgroundColor = UIColor.grayColor()
            print("Total is now \(total)")
            self.updateTotalLabel()
        }
        
        
        return true
    }
    
    //DeselectedCell
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.mainMenu.cellForItemAtIndexPath(indexPath) as! MenuItemCell
        cell.selectedForBuy = false
        self.total = total - (cell.item?.price)!
        
        self.updateIndexes(cell.item!.indexSpot!)
        cell.backgroundColor = UIColor.clearColor()
        self.updateTotalLabel()
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView =
        collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Section", forIndexPath: indexPath) as! MenuItemView
        headerView.setUp(indexPath.section)
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! MenuItemCell
        
        if cell.selected == true {
            cell.backgroundColor = UIColor.grayColor()
            
        }
    }
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) ->  Bool {
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }
    
    func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let VC = segue.destinationViewController as! SpecialRequestViewController
        VC.menuItems = self.chosenItems
    }
    
}

