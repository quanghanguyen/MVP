//
//  ViewController.swift
//  MVP
//
//  Created by Nguyen Quang Ha on 10/10/2022.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var users = [User]()
    
    private let presenter = UserPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        
        //View
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //Handle Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle the tap on items
        presenter.didTapUser(user: users[indexPath.row])
    }
    
    // Presenter delegate
    func presentUsers(user users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

