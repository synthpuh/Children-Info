//
//  ChildCellDelegate.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

protocol ChildCellDelegate {
    func updateChild(number: Int, withName name : String?, withAge age: Int?)
    func deleteChild(number: Int)
}
