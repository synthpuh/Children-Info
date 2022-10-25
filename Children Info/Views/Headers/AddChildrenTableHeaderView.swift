//
//  AddChildrenTableHeaderView.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

import UIKit

class AddChildrenTableHeaderView: UITableViewHeaderFooterView {
    
    static let reuseId = "AddChildrenTableHeaderView"
    
    var delegate: AddChildrenDelegate?
    
    var maxChildren: Int = 0 {
        didSet {
            descriptionLabel.text = "Дети (макс. \(maxChildren))"
        }
    }
    
    var isButtonHidden = false {
        didSet {
            addChildButton.isHidden = isButtonHidden
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var addChildButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func addChildTapped(_ sender: UIButton) {
        delegate?.addField()
    }
    
    func setupUI() {
        
        addChildButton.layer.borderColor = UIColor.systemBlue.cgColor
        addChildButton.layer.borderWidth = 2.0
        addChildButton.layer.cornerRadius = addChildButton.bounds.height / 2
        
    }
}
