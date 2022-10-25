//
//  ClearAllTableViewCell.swift
//  Children Info
//
//  Created by Ольга Шубина on 25.10.2022.
//

import UIKit

class ClearAllTableViewCell: UITableViewCell {
    
    static let reuseId = "ClearAllTableViewCell"

    @IBOutlet weak var clearButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearButton.layer.borderColor = UIColor.systemRed.cgColor
        clearButton.layer.borderWidth = 2.0
        clearButton.layer.cornerRadius = clearButton.bounds.height / 2
    }

}
