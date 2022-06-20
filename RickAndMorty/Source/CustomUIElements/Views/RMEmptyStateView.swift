//
//  RMEmptyStateView.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class RMEmptyStateView: UIView {
    let logoImageView = RMAvatarImageView(frame: .zero)
    let messageLabel = RMTitleLabel(textAlignment: .center, fontSize: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(massage: String) {
        self.init(frame: .zero)
        messageLabel.text = massage
    }

    private func configure() {
        [messageLabel, logoImageView].forEach { addSubview($0) }

        configureMassageLabel()
        configureLogoImageView()
    }

    private func configureMassageLabel() {
        messageLabel.numberOfLines = 1
        messageLabel.textColor = .secondaryLabel

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func configureLogoImageView() {
        logoImageView.image = Images.placeholder
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
