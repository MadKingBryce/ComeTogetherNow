//
//  Restaurant.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/21/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse

class Restaurant: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return ("Restaurant")
    }
    
    @NSManaged var name : String
    @NSManaged var postcode : Int
    @NSManaged var longitude : Double
    @NSManaged var latitude : Double
    @NSManaged var category : Int
    @NSManaged var menu : Menu;
}
