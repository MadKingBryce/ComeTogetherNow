//
//  Utils.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/28/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit
import Foundation

class Utils: NSObject {
    
    
    var categoryDictionary = ["Burgers", "Chicken", "Side", "Salad", "Deserts", "Misc"]
    
    func xyz(rest: Restaurant) {
        let thisItem = MenuItem()
        thisItem.name = "Cheese"
        thisItem.owner = rest
        thisItem.saveInBackgroundWithBlock { (yes, err) -> Void in
            let menu = Menu()
            menu.items[0] = thisItem
        
            menu.saveInBackground()
        }
    }
    
}