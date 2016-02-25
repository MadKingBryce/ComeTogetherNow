//
//  Menu.swift
//  ComeTogetherNow
//
//  Created by Bryce              Greene on 1/28/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Parse

class Menu: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return ("Menu")
    }

    @NSManaged var owner : Restaurant
    @NSManaged var items : [MenuItem]
}
