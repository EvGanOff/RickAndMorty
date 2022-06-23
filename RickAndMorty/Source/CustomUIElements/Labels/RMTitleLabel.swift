//
//  RMTitleLabel.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class RMTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }

    private func configure() {
        textColor = .label
        minimumScaleFactor = 0.7
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byCharWrapping
        translatesAutoresizingMaskIntoConstraints = false
        text = "Some Text"
    }
}
