//
//  DitailCharactersVC.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class DitailCharactersVC: RMDataLoadingVC {

    private lazy var conteinerView: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemBackground

        return container
    }()

    let avatarImageView = RMAvatarImageView(frame: .zero)
    let charectersNameLabel = RMTitleLabel(textAlignment: .center, fontSize: 24)
    let charectersGenderLabel = RMSecondaryTitleLabel(fontSize: 20)
    let charectersSpecieLabel = RMBodyLabel(textAlignment: .center)
    let charecterStatus = RMBodyLabel(textAlignment: .center)

    var presenter: DetailsViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getCherecters()
        configureViewController()
        configureViews()
        configureLayouts()

    }

    private func configureViewController() {
        title = presenter?.characters?.name
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureViews() {
        view.addSubview(conteinerView)

        [avatarImageView, charectersNameLabel, charectersGenderLabel, charectersSpecieLabel, charecterStatus].forEach {
            conteinerView.addSubview($0)
        }

        charectersNameLabel.textColor = .label
        charectersGenderLabel.textAlignment = .center
    }

    private func configureLayouts() {

        let paddings: CGFloat = 8

        NSLayoutConstraint.activate([

            conteinerView.topAnchor.constraint(equalTo: view.topAnchor, constant: Matrics.conteinerViewTopAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddings),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddings),
            conteinerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -paddings),

            avatarImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: paddings),
            avatarImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: paddings),
            avatarImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -paddings),
            avatarImageView.heightAnchor.constraint(equalToConstant: Matrics.avatarImageViewHeightAnchor),

            charectersNameLabel.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor),
            charectersNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: paddings),
            charectersNameLabel.heightAnchor.constraint(equalToConstant: Matrics.viewsHeightAnchor),
            charectersNameLabel.widthAnchor.constraint(equalToConstant: Matrics.viewsWidthAnchor),

            charectersGenderLabel.topAnchor.constraint(equalTo: charectersNameLabel.bottomAnchor, constant: paddings),
            charectersGenderLabel.centerXAnchor.constraint(equalTo: charectersNameLabel.centerXAnchor),
            charectersGenderLabel.heightAnchor.constraint(equalToConstant: Matrics.viewsHeightAnchor),
            charectersGenderLabel.widthAnchor.constraint(equalToConstant: Matrics.viewsWidthAnchor),

            charectersSpecieLabel.topAnchor.constraint(equalTo: charectersGenderLabel.bottomAnchor, constant: paddings),
            charectersSpecieLabel.centerXAnchor.constraint(equalTo: charectersGenderLabel.centerXAnchor),
            charectersSpecieLabel.heightAnchor.constraint(equalToConstant: Matrics.viewsHeightAnchor),
            charectersSpecieLabel.widthAnchor.constraint(equalToConstant: Matrics.viewsWidthAnchor),

            charecterStatus.topAnchor.constraint(equalTo: charectersSpecieLabel.bottomAnchor, constant: paddings),
            charecterStatus.centerXAnchor.constraint(equalTo: charectersSpecieLabel.centerXAnchor),
            charecterStatus.heightAnchor.constraint(equalToConstant: Matrics.viewsHeightAnchor),
            charecterStatus.widthAnchor.constraint(equalToConstant: Matrics.viewsWidthAnchor),

        ])
    }

    private enum Matrics {
        static let conteinerViewTopAnchor: CGFloat = 150
        static let avatarImageViewHeightAnchor: CGFloat = 370
        static let viewsHeightAnchor: CGFloat = 20
        static let viewsWidthAnchor: CGFloat = 200
    }
}

extension DitailCharactersVC: DetailsViewProtocol {

    func succes() {
        charectersNameLabel.text = presenter?.characters?.name
        charectersGenderLabel.text = presenter?.characters?.gender
        charectersSpecieLabel.text = presenter?.characters?.species
        charecterStatus.text = presenter?.characters?.status

        // Пофиксить синглтон
        NetworkManager.shared.downloadImage(from: presenter?.characters?.image ?? "", completion: { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        })
    }

    func failure(error: RMErrors) {
        print(error.rawValue)
    }
}
