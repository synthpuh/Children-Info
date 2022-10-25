//
//  InputsView.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

import UIKit

class InputsView: UIView {
    
    var delegate: InputsViewDelegate?
    
    lazy var nameView: UIView = {
        return createInputView()
    }()
    
    lazy var nameLabel: UILabel = {
        return createLabel(withName: "Имя")
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = createTextField()
        textField.textContentType = .name
        return textField
    }()
    
    lazy var ageView: UIView = {
        return createInputView()
    }()
    
    lazy var ageLabel: UILabel = {
        return createLabel(withName: "Возраст")
    }()
    
    lazy var ageTextField: UITextField = {
        let textField = createTextField()
        textField.keyboardType = .numberPad
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func addTargets() {
        nameTextField.addTarget(self, action: #selector(nameDidChange), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(ageDidChange), for: .editingChanged)
    }
}

// MARK: - Actions

extension InputsView {
    
    @objc private func nameDidChange() {
        delegate?.changeName(to: nameTextField.text)
    }
    
    @objc private func ageDidChange() {
        guard let age = Int(ageTextField.text ?? "") else { return }
        delegate?.changeAge(to: age)
    }
}

//MARK: - UITextFieldDelegate methods

extension InputsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
    
//MARK: - UI

extension InputsView {
    
    func setDefaultFields() {
        nameTextField.text = nil
        ageTextField.text = nil
    }
    
    func setTextFields(withName name: String?, andAge age: Int?) {
        nameTextField.text = name
        guard let age = age else {
            ageTextField.text = nil
            return
        }
        ageTextField.text = "\(age)"
    }
    
    private func setupView() {
        addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameTextField)
        
        addSubview(ageView)
        ageView.addSubview(ageLabel)
        ageView.addSubview(ageTextField)
        
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        ageTextField.delegate = self
        
        nameTextField.tag = 0
        ageTextField.tag = 1
        
        addTargets()
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
            nameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            nameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            nameView.heightAnchor.constraint(equalToConstant: 62.0),
            
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 8.0),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 16.0),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4.0),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 16.0),
            nameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -16.0),
            nameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -4.0),
            
            ageView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 8.0),
            ageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            ageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            ageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0),
            ageView.heightAnchor.constraint(equalToConstant: 62.0),
            
            ageLabel.topAnchor.constraint(equalTo: ageView.topAnchor, constant: 8.0),
            ageLabel.leadingAnchor.constraint(equalTo: ageView.leadingAnchor, constant: 16.0),
            
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 4.0),
            ageTextField.leadingAnchor.constraint(equalTo: ageView.leadingAnchor, constant: 16.0),
            ageTextField.trailingAnchor.constraint(equalTo: ageView.trailingAnchor, constant: -16.0),
            ageTextField.bottomAnchor.constraint(equalTo: ageView.bottomAnchor, constant: -4.0)
        ])
    }
    
    private func createInputView() -> UIView {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createLabel(withName name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
