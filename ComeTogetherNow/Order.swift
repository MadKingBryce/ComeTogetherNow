//
//  Order.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 2/11/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse 
class Order: PFObject {
    
    @NSManaged var user : User?
    @NSManaged var order : [MenuItem]?
    @NSManaged var specialRequests : [[String]]    //Since optionals cannot be represented in Objective-C we use a matrix [ [], ["foo"]]  =  [ nil, foo ]
    @NSManaged var dayOfOrder :  NSDate
    @NSManaged var totalCost : Double
    @NSManaged var destinationAddress : String
    @NSManaged var timeToComplete : Double
    
}
