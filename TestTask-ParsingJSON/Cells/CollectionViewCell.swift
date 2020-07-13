//
//  CollectionViewCell.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var isActiveBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
