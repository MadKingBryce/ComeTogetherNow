//
//  MenuItemCell.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 1/28/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    var item  : MenuItem?
    var owner : Restaurant?
    var indexSpot : Int?
    var selectedForBuy : Bool = false
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
}
