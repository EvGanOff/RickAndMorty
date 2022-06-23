//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/15/22.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    static let userID = "CharacterCell"

    var avatarImageView = RMAvatarImageView(frame: .zero)

    let charectersNameLabel = RMTitleLabel(textAlignment: .center, fontSize: 18)
    let charectersGenderLabel = RMSecondaryTitleLabel(fontSize: 16)
    let charectersSpecieLabel = RMBodyLabel(textAlignment: .center)
    var presenter: MainViewPresenterProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(characterName: Characters) {
        // Переписать в презентер
        //let char = presenter?.characters
        charectersNameLabel.text = characterName.name
        charectersSpecieLabel.text = characterName.species
        charectersGenderLabel.text = characterName.gender
        NetworkManager.shared.downloadImage(from: characterName.image ?? "", completion: { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        })
    }

    private func configure() {
        addSubview(avatarImageView)
        addSubview(charectersNameLabel)
        addSubview(charectersGenderLabel)
        addSubview(charectersSpecieLabel)
        charectersGenderLabel.textAlignment = .center
        charectersGenderLabel.textColor = .secondaryLabel
        charectersSpecieLabel.font = UIFont.systemFont(ofSize: 16)


        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: Metrics.padding),
            avatarImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: Metrics.padding),
            avatarImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            charectersNameLabel.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor, constant: Metrics.userNameLabelPadding),
            charectersNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.padding),
            charectersNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.padding),
            charectersNameLabel.heightAnchor.constraint(equalToConstant: Metrics.userNameLabelHeightAnchorPadding),

            charectersSpecieLabel.topAnchor.constraint(equalTo: charectersNameLabel.bottomAnchor, constant: Metrics.padding),
            charectersSpecieLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.padding),
            charectersSpecieLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.padding),
            charectersSpecieLabel.heightAnchor.constraint(equalToConstant: Metrics.userNameLabelHeightAnchorPadding),

            charectersGenderLabel.topAnchor.constraint(equalTo: charectersSpecieLabel.bottomAnchor, constant: Metrics.padding),
            charectersGenderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.padding),
            charectersGenderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.padding),
            charectersGenderLabel.heightAnchor.constraint(equalToConstant: Metrics.userNameLabelHeightAnchorPadding)

        ])
    }

    private struct Metrics {
        static let padding: CGFloat = 5
        static let userNameLabelPadding: CGFloat = 5
        static let userNameLabelHeightAnchorPadding: CGFloat = 20
    }
}
