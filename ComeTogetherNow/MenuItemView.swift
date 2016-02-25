//
//  MenuItemView.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 2/9/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit

class MenuItemView: UICollectionReusableView {
    
    @IBOutlet weak var label: UILabel!
    
     var categoryLibA = ["Burgers", "Chicken", "Side", "Salad", "Deserts", "Misc"]
    
    func setUp(indexRow : Int) {
        self.label.text = categoryLibA[indexRow]
    }
        
}
