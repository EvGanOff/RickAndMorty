//
//  DeteilsViewPresentor.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import Foundation

// MARK: - Output Protocol -

protocol DetailsViewProtocol: AnyObject {
   // func showPersonInformation(_ person: Person)
    func updatePersonInformation()
}

protocol DetailsViewPresenterProtocol {
    init(view: DetailsViewProtocol, networkManager: NetworkManager)
}

class DeteilsViewPresentor: DetailsViewPresenterProtocol {

    // MARK: - Properties -

    weak var view: DetailsViewProtocol?
    var networkManager: NetworkManager?
    var characters: [Characters]?
    var coordinator: MainCoordinator?

    // MARK: - Required Initialization -

    required init(view: DetailsViewProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
    }




}
