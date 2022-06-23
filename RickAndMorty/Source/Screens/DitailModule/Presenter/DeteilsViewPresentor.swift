//
//  DeteilsViewPresentor.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import Foundation

// MARK: - Output Protocol -

protocol DetailsViewProtocol: AnyObject {
    func succes()
    func failure(error: RMErrors)
}

protocol DetailsViewPresenterProtocol {
    init(view: DetailsViewProtocol, networkManager: NetworkManager)
    var characters: Characters? { get }
    func getCherecters()

}

class DeteilsViewPresentor: DetailsViewPresenterProtocol {

    // MARK: - Properties -

    weak var view: DetailsViewProtocol?
    var networkManager: NetworkManager?
    var characters: Characters?
    var coordinator: MainCoordinator?
    var namber = 1

    // MARK: - Required Initialization -

    required init(view: DetailsViewProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
    }

    func getCherecters() {
        namber = characters?.id ?? 1
        networkManager?.getCharactersInfo(number: namber, completed: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self.characters? = character
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}
