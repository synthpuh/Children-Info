//
//  ParentTableViewCell.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

import UIKit

class ParentTableViewCell: UITableViewCell {
    
    static let reuseId = "ParentTableViewCell"
    
    var delegate: ParentInfoDelegate?
    
    var parent: FamilyMember? {
        didSet {
            inputsView.setTextFields(withName: parent?.name, andAge: parent?.age)
        }
    }

    @IBOutlet weak var inputsView: InputsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputsView.delegate = self
        inputsView.setTextFields(withName: parent?.name, andAge: parent?.age)
    }
    
    override func prepareForReuse() {
        inputsView.setDefaultFields()
    }
}

//MARK: - InputsViewDelegate methods

extension ParentTableViewCell: InputsViewDelegate {
    
    func changeName(to newName: String?) {
        guard let newName = newName else { return }
        delegate?.updateName(with: newName)
    }
    
    func changeAge(to age: Int) {
        delegate?.updateAge(with: age)
    }
}
