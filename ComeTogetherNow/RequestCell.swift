//
//  RequestCell.swift
//  ComeTogetherNow
//
//  Created by Bryce  Greene on 2/23/16.
//  Copyright © 2016 Topside Tech. All rights reserved.
//

import UIKit

class RequestCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestField: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
