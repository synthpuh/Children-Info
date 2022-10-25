//
//  ChildTableViewCell.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
    
    static let reuseId = "ChildTableViewCell"
    
    var childNumber: Int?
    var child: FamilyMember? {
        didSet {
            inputsView.setTextFields(withName: child?.name, andAge: child?.age)
        }
    }
    
    var delegate: ChildCellDelegate?

    @IBOutlet weak var inputsView: InputsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputsView.delegate = self
        inputsView.setTextFields(withName: child?.name, andAge: child?.age)
    }
    
    override func prepareForReuse() {
        inputsView.setDefaultFields()
    }
    
    @IBAction func deleteChildTapped(_ sender: UIButton) {
        guard let childNumber = childNumber else { return }
        delegate?.deleteChild(number: childNumber)
    }
}

extension ChildTableViewCell: InputsViewDelegate {
    func changeName(to newName: String?) {
        guard let childNumber = childNumber else { return }
        delegate?.updateChild(number: childNumber, withName: newName, withAge: nil)
    }
    
    func changeAge(to age: Int) {
        guard let childNumber = childNumber else { return }
        delegate?.updateChild(number: childNumber, withName: nil, withAge: age)
    }
}
