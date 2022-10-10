//
//  Presenter.swift
//  MVP
//
//  Created by Nguyen Quang Ha on 10/10/2022.
//

import Foundation
import UIKit

// API: https://jsonplaceholder.typicode.com/users

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(user: [User])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    
    weak var delegate: PresenterDelegate?
    
    public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(user: users)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    public func didTapUser(user: User) {
        delegate?.presentAlert(
            title: user.name ?? "",
            message: "\(String(describing: user.username)) \n \(String(describing: user.email))")
    }
}
