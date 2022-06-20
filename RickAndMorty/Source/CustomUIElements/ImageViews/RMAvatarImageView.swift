//
//  RMAvatarImageView.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class RMAvatarImageView: UIImageView {

    let placeholderImage = Images.placeholder

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        image = placeholderImage
    }
}
