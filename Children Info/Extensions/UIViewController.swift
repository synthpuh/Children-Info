//
//  UIViewController.swift
//  Children Info
//
//  Created by Ольга Шубина on 25.10.2022.
//

import UIKit

extension UIViewController {
    
    func hideKeyBoardOnTaps() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func showError(error: PossibleError) {
        var alert = UIAlertController()
        
        switch error {
        case .noParent:
            alert = UIAlertController(title: "Данные родителя отсутствуют", message: "Сначала заполните данные родителя", preferredStyle: .alert)
        case .previousChildEmpty:
            alert = UIAlertController(title: "Данные предыдущего ребенка не полные", message: "Сначала заполните данные предыдущего ребенка", preferredStyle: .alert)
        }
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
