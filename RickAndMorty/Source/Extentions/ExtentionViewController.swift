//
//  ExtentionViewController.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/15/22.
//

import UIKit

extension UIViewController {
    func presentsRMlertController(title: String, massage: String, buttonTitle: String) {
        let alertVC = RMAlertViewController(alertTitle: title, massege: massage, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
}

