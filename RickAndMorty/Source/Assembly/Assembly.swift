//
//  Assembly.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

protocol MainAssembly {
    static func createMainModule(_ coordinator: MainCoordinator) -> UIViewController
    static func createDetailsModule(_ model: Characters?, _ coordinator: MainCoordinator) -> UIViewController
}

class MainScreenBuilder: MainAssembly {

    static func createMainModule(_ coordinator: MainCoordinator) -> UIViewController {
        let view = CharactersListViewController()
        let networkManager = NetworkManager()
        let presenter = MainViewPresenter(view: view, networkManager: networkManager)

        view.presenter = presenter
        presenter.networkManager = networkManager
        presenter.coordinator = coordinator

        return view
    }

    static func createDetailsModule(_ model: Characters?, _ coordinator: MainCoordinator) -> UIViewController {
        let view = DitailCharactersVC()
        let networkManager = NetworkManager()
        let presenter = DeteilsViewPresentor(view: view, networkManager: networkManager)

        view.presenter = presenter
        presenter.networkManager = networkManager
        presenter.coordinator = coordinator
        presenter.characters = model

        return view
    }
}
