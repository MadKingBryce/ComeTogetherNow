//
//  RestaurantCell.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/21/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import Parse
import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    var theRest : Restaurant?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(theRest : Restaurant) {
        
        self.theRest = theRest
        let user = PFUser.currentUser() as! User
        self.nameLabel.text = self.theRest!.name
        let x = PFGeoPoint(latitude: (self.theRest!.latitude), longitude: (self.theRest!.longitude))
        let tempDouble = Double(round(user.lastLocation().distanceInMilesTo(x) * 1000))
        print("\(tempDouble)")
        self.awayLabel.text = "\(tempDouble/10) miles away"

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    

}
