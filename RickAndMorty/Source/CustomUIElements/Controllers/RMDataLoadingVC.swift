//
//  RMDataLoadingVC.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class RMDataLoadingVC: UIViewController {

    // MARK: - Properties -

    var containerView: UIView!

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()

    private func configureContainerView() {
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }

    func showLoadingView() {
        configureContainerView()
        view.addSubview(containerView)


        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }

        containerView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoaddingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    func showEmptyStateView(with massege: String, in view: UIView) {
        let emptyStateView = RMEmptyStateView(massage: massege)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
