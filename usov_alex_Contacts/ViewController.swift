//
//  ViewController.swift
//  usov_alex_Contacts
//
//  Created by Алексей Попроцкий on 18.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let cellID = "contactCellIdentifier"
    var storageUserDefault: ContactStorageProtocol!
    
    private var contacts = [ContactProtocol]() {
        didSet {
            storageUserDefault.save(contacts: contacts)
            contacts.sort { $0.title < $1.title }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageUserDefault = ContactStorage()
        loadContacts()
    }

    private func loadContacts() { // заполнить массив номерами
        contacts = storageUserDefault.load()
//        contacts.append(Contact(title: "Alex", phone: "+79381234433"))
//        contacts.append(Contact(title: "Den", phone: "+79996385190"))
//        contacts.append(Contact(title: "Bro", phone: "+79246889749"))
    }

    @IBOutlet var tableView: UITableView!
    
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(title: "Создать новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Номер телефона"
        }
        
        let createContactButton = UIAlertAction(title: "Создать", style: .default) { alert in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text
            else {
                return
            }
            let newContact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(newContact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(createContactButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        // переиспользуем старую ячейку, если она есть
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellID) {
            cell = reuseCell
        } else {
            // Создаем новую ячейку, получаем экземпляр ячейки от tableView.
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        configCell(cell: &cell, for: indexPath)
        
        return cell
    }
    
    // Конфигурируем ячейку
    private func configCell(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configCell = cell.defaultContentConfiguration() // метод возвращает пустую конфигурацию ячейки
        configCell.text = contacts[indexPath.row].title // Данная пустая конфигурация наполняется данными
        configCell.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configCell // Наполненная конфигурация передается ячейке
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDel])
        return actions
    }
}
