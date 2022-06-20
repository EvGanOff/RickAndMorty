//
//  MainViewPresentor.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import Foundation

// MARK: - Output Protocol -

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: RMErrors)
}

// MARK: - Input Protocol -

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkManager: NetworkManager)
    func getCherecters()
    func getMoreCherecters()
    func selectPersonAt(index: Int)
    var characters: [Characters]? { get set }
}

class MainViewPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol?
    
    var characters: [Characters]?
    var networkManager: NetworkManager?
    var coordinator: MainCoordinator?
    var characterName: String? = nil
    var page = 1

    required init(view: MainViewProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        getCherecters()
    }

    func getCherecters() {
        networkManager?.getCharacters(page: page, completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let character):
                    self.characters = character
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }

    func getMoreCherecters() {
        page += 1
        networkManager?.getCharacters(page: page, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self.characters?.append(contentsOf: character)
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }

    func selectPersonAt(index: Int) {
        guard let person = characters else { return }
        coordinator?.pushTo(.detail(person))
        networkManager?.getCharacters(page: page, completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let character):
                    self.characters = character
                    //print("\(character)")
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}
