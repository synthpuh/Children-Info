//
//  MainTableViewController.swift
//  Children Info
//
//  Created by Ольга Шубина on 24.10.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var familyModel = FamilyModel()
    
    private var isMaxChildrenReached = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyBoardOnTaps()
        
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: ParentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ParentTableViewCell.reuseId)
        tableView.register(UINib(nibName: ChildTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ChildTableViewCell.reuseId)
        tableView.register(UINib(nibName: ClearAllTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ClearAllTableViewCell.reuseId)
        tableView.register(UINib(nibName: AddChildrenTableHeaderView.reuseId, bundle: nil), forHeaderFooterViewReuseIdentifier: AddChildrenTableHeaderView.reuseId)
        tableView.register(UINib(nibName: ParentHeaderView.reuseId, bundle: nil), forHeaderFooterViewReuseIdentifier: ParentHeaderView.reuseId)
    }
}

// MARK: - ClearTableDelegate Methods {

extension MainTableViewController: ClearTableDelegate {
    func showDeletionAlert() {
        
        let alert = UIAlertController(title: "Удалить все данные?", message: "Это действие необратимо", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] action in
            guard let self = self else { return }
            self.familyModel.clearFamily()
            self.isMaxChildrenReached = false
            UIView.transition(with: self.tableView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in self?.tableView.reloadData() })
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

// MARK: - ParentInfoDelegate methods

extension MainTableViewController: ParentInfoDelegate {
    
    func updateName(with name: String) {
        familyModel.changeParent(name: name)
    }
    
    func updateAge(with age: Int) {
        familyModel.changeParent(age: age)
    }
}

// MARK: - AddChildrenDelegate methods

extension MainTableViewController: AddChildrenDelegate {
    func addField() {
        guard familyModel.parent != nil else {
            showError(error: .noParent)
            return
        }
        
        if familyModel.children.count == 0 {
            familyModel.addChild()
            isMaxChildrenReached = false
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .fade)
        } else {
            guard familyModel.children.last?.name != "", familyModel.children.last?.age != nil else {
                showError(error: .previousChildEmpty)
                return
            }
            familyModel.addChild()
            if familyModel.children.count >= 5 {
                isMaxChildrenReached = true
                tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .fade)
                tableView.reloadData()
            } else {
                isMaxChildrenReached = false
                tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .fade)
            }
        }
    }
}

// MARK: - ChildCellDelegate methods

extension MainTableViewController: ChildCellDelegate {
    
    func updateChild(number: Int, withName name: String?, withAge age: Int?) {
        familyModel.changeChild(number: number, withName: name, andAge: age)
    }
    
    func deleteChild(number: Int) {
        familyModel.deleteChild(number: number)
        isMaxChildrenReached = false
        tableView.deleteRows(at: [IndexPath(row: familyModel.children.count - number, section: 1)], with: .fade)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewController DataSource methods

extension MainTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return familyModel.children.count + 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ParentHeaderView.reuseId) as? ParentHeaderView else { return UITableViewHeaderFooterView() }
            return header
        case 1:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddChildrenTableHeaderView.reuseId) as? AddChildrenTableHeaderView else { return UITableViewHeaderFooterView() }
            header.maxChildren = familyModel.maxChildren
            header.isButtonHidden = isMaxChildrenReached
            header.delegate = self
            return header
        default:
            return UITableViewHeaderFooterView()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParentTableViewCell.reuseId, for: indexPath) as? ParentTableViewCell else { return UITableViewCell() }
            cell.parent = familyModel.parent
            cell.delegate = self
            return cell
        case 1:
            switch indexPath.row {
            case ..<familyModel.children.count:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildTableViewCell.reuseId, for: indexPath) as? ChildTableViewCell else { return UITableViewCell() }
                cell.delegate = self
                cell.child = familyModel.children[familyModel.children.count - indexPath.row - 1]
                cell.childNumber = familyModel.children.count - indexPath.row - 1
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ClearAllTableViewCell.reuseId, for: indexPath) as? ClearAllTableViewCell else { return UITableViewCell() }
                cell.delegate = self
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}
