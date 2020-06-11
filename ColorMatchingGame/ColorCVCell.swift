//
//  ColorCVCell.swift
//  ColorMatchingGame
//
//  Created by Toriq Wahid Syaefullah on 11/06/20.
//  Copyright © 2020 Toriq Wahid Syaefullah. All rights reserved.
//

import UIKit

class ColorCVCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    override var isSelected: Bool{
        didSet{
//            print(isSelected)
            if !isSelected {
                layer.cornerRadius = 10
            } else {
                layer.cornerRadius = 30
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
