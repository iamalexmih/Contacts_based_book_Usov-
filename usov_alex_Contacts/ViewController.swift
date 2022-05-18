//
//  ViewController.swift
//  usov_alex_Contacts
//
//  Created by Алексей Попроцкий on 18.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let cellID = "contactCellIdentifier"
    
    private var contacts = [ContactProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }

    private func loadContacts() { // заполнить массив номерами
        contacts.append(Contact(title: "Alex", phone: "+79381234433"))
        contacts.append(Contact(title: "Den", phone: "+79996385190"))
        contacts.append(Contact(title: "Bro", phone: "+79246889749"))
        contacts.sort{ $0.title < $1.title }
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
