//
//  TableViewCell.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var isActiveLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        isActiveLabel.layer.masksToBounds = true
        isActiveLabel.layer.cornerRadius = 15
    }
    
}
