//
//  RMAlertViewController.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class RMAlertViewController: UIViewController {

    let containerView = RMAlertConteinerView()
    let titleLabel = RMTitleLabel(textAlignment: .center, fontSize: 26)
    let massageLabel = RMBodyLabel(textAlignment: .center)
    let actionButton = RMButton(title: "OK", backgroundColor: .systemGreen)

    var alertTitle: String?
    var massege: String?
    var buttonTitle: String?

    init(alertTitle: String, massege: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.massege = massege
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        setupHierarchy()
        configureConteinerView()
        configureTitleLabel()
        configureActionButton()
        configureMassageLabel()
    }

    private func setupHierarchy() {
        [containerView, titleLabel, massageLabel, actionButton].forEach { view.addSubview($0) }
        containerView.addSubview(titleLabel)
        containerView.addSubview(actionButton)
        containerView.addSubview(massageLabel)
    }

    private func configureConteinerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: Metrics.containerViewWidthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: Metrics.containerViewHeightAnchor)
        ])
    }

    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Error"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.titleLabelPadding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.titleLabelPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.titleLabelPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: Metrics.titleLabelHeightAnchor)
        ])
    }

    private func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor , constant: -Metrics.actionButtonPadding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.actionButtonPadding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.actionButtonPadding),
            actionButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    func configureMassageLabel() {
        massageLabel.text = massege ?? "Eror"
        massageLabel.numberOfLines = 4
        massageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            massageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            massageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.massageLabelPadding),
            massageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.massageLabelPadding),
            massageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }

    @objc func dismissVC() {
        dismiss(animated: true)
    }

    private struct Metrics {
        static let containerViewWidthAnchor: CGFloat = 300
        static let containerViewHeightAnchor: CGFloat = 220
        static let titleLabelPadding: CGFloat = 20
        static let actionButtonPadding: CGFloat = 20
        static let massageLabelPadding: CGFloat = 20
        static let titleLabelHeightAnchor: CGFloat = 30
    }
}
