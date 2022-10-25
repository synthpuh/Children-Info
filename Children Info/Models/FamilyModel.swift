//
//  FamilyModel.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

class FamilyModel {
    
    var parent: FamilyMember?
    var children: [FamilyMember]
    
    var maxChildren = 5
    
    init(parent: FamilyMember? = nil, children: [FamilyMember] = []) {
        self.parent = parent
        self.children = children
    }
    
    func clearFamily() {
        self.parent = nil
        self.children = []
    }
    
    func addChild() {
        self.children.append(FamilyMember(name: "", age: nil))
    }
    
    func deleteChild(number: Int) {
        self.children.remove(at: number)
    }
    
    func changeChild(number: Int, withName name: String?, andAge age: Int?) {
        guard number < children.count else {
            self.addChild()
            return
        }
        
        if let name = name {
            children[number].name = name
        }
        
        if let age = age {
            children[number].age = age
        }
    }
    
    func changeParent(name: String? = nil, age: Int? = nil) {
        guard let _ = self.parent else {
            self.parent = FamilyMember(name: name ?? "", age: age ?? 0)
            return
        }
        
        if let name = name {
            self.parent?.name = name
        }
        
        if let age = age {
            self.parent?.age = age
        }
    }
}
