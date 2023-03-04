//
//  LoginViewController.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 23.02.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //   MARK: - UI Elements -> Halil İbrahim Elkan..

    //   MARK: - Properties -> Halil İbrahim Elkan..
    
    //   MARK: - Life Cyle -> Halil İbrahim Elkan..
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            var controller = HomeViewController()
            controller.modalPresentationStyle = .custom
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true, completion: nil)
        }
    }
    //   MARK: - Functions -> Halil İbrahim Elkan..
    
    //   MARK: - Actions -> Halil İbrahim Elkan..
   
}
