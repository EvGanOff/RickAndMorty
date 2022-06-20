//
//  RMBodyLabel.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class RMBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }

    private func configure() {
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .caption1)
        minimumScaleFactor = 0.75
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byCharWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
