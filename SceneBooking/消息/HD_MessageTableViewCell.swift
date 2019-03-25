//
//  HD_MessageTableViewCell.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/25.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_MessageTableViewCell: UITableViewCell, RegisterCellFromNib {

    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
