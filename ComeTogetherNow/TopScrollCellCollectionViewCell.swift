//
//  TopScrollCellCollectionViewCell.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 2/19/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit

class TopScrollCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var header: UILabel!
    var tagNum = 0;
    var categoryLibA = ["Burgers", "Chicken", "Side", "Salad", "Deserts", "Misc"]
    var categoryLibB = ["All", "Burgers", "Asian", "Mexican", "Seafood", "Other"]
    func setUpCell(category: Int) {
        var head : String = "Header Here"
        
        if self.tagNum == 1 {
            head = categoryLibA[category]
            
        } else if tagNum == 2 {
            head = categoryLibB[category]
            
            
            self.backgroundColor = UIColor.clearColor()
        }
        self.header.text = head
    }
    
}
