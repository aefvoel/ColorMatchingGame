//
//  TextCVCell.swift
//  ColorMatchingGame
//
//  Created by Toriq Wahid Syaefullah on 15/06/20.
//  Copyright © 2020 Toriq Wahid Syaefullah. All rights reserved.
//

import UIKit

class TextCVCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
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
    
    public func configure(with model: cellData) {
        textLabel.textColor = model.color
        textLabel.text = model.text
    }
    
}
