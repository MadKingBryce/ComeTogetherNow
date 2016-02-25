//
//  MenuItem.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/28/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse


class MenuItem: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return ("MenuItem")
    }
    var indexSpot : Int?

    @NSManaged var owner : Restaurant
    @NSManaged var name  : String
    @NSManaged var price : Double
    @NSManaged var Classification : Int //[ Burgers = 0, Chicken = 1, Salad = 2, Sides = 3, Deserts = 4]
    
    

}
