//
//  User.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/21/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import Parse
import UIKit

class User: PFUser {
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }

    
    @NSManaged var lastLatitude : Double
    @NSManaged var lastLongitude: Double
    @NSManaged var tray : User

    
    
    func lastLocation() -> PFGeoPoint {
        return PFGeoPoint(latitude: lastLatitude, longitude: lastLongitude)
    }

}
