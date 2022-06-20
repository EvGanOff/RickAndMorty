//
//  DitailCharactersVC.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class DitailCharactersVC: RMDataLoadingVC {

    var presenter: DetailsViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}

extension DitailCharactersVC: DetailsViewProtocol {
    func updatePersonInformation() {
        
    }
}
