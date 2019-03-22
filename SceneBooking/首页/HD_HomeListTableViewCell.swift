//
//  HD_HomeListTableViewCell.swift
//  SceneBooking
//
//  Created by 段新瑞 on 2019/3/21.
//  Copyright © 2019 谢樘飞燕. All rights reserved.
//

import UIKit

class HD_HomeListTableViewCell: UITableViewCell, RegisterCellFromNib {

    
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var otherLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
