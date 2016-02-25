//
//  SpecialRequestViewController.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 2/22/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit

class SpecialRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var specialRequests : [String?] = []
    var menuItems : [MenuItem]?
    var selectedCellIndexPaths: [NSIndexPath] = []
    
    @IBOutlet weak var requestsTableView: UITableView!
    
    
    
    
    
//MARK: UITableView Functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("😂")
        return menuItems!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RequestCell", forIndexPath: indexPath) as! RequestCell
        
        cell.nameLabel.text = menuItems![indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if selectedCellIndexPaths.contains(indexPath) {
            return 200
        }
        return 40
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
      
        selectedCellIndexPaths.append(indexPath)
            
        tableView.beginUpdates()
        tableView.endUpdates()
            
        if selectedCellIndexPaths.count != 0 {
                
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
                
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedCellIndexPaths.removeAll()
        
    
        
    }

    //40-200
    
//MARK: Basic VC Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestsTableView.delegate = self
        requestsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
