//
//  MainCoordinator.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

enum Destination {
    case main([Characters])
    case detail(Characters)
}

protocol DetailCoordinating: AnyObject {
    func popTo(_ destination: Destination)
}

protocol MainCoordinating: AnyObject {
    func pushTo(_ destination: Destination)
}

class MainCoordinator: Coordinatable {

    // MARK: - Properties -

    weak var parent: Coordinatable?
    var childCoordinators: [Coordinatable] = []

    // MARK: - Private properties -

    private let navigationController: UINavigationController


    // MARK: - Initializer -

    init(navigationController: UINavigationController, parent: Coordinatable? = nil) {
        self.navigationController = navigationController
        self.parent = parent
    }

    // MARK: - Public Methods -

    func start() {
        let viewController = MainScreenBuilder.createMainModule(self)
        navigationController.pushViewController(viewController, animated: true)
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }
}

    // MARK: - DetailCoordinating

extension MainCoordinator: DetailCoordinating {
    func popTo(_ destination: Destination) {
        switch destination {
        case .main:
            guard let viewController = navigationController.viewControllers.first(where: { viewController in
                viewController is CharactersListViewController }) else { return }
            viewController.viewDidLoad()
            navigationController.popToViewController(viewController, animated: true)
        case .detail:
            break
        }
    }
}

    // MARK: - MainCoordinating -

extension MainCoordinator: MainCoordinating {
    func pushTo(_ destination: Destination) {
        switch destination {
        case .main:
            break
        case .detail(let model):
            let viewController = MainScreenBuilder.createDetailsModule(model, self)
            navigationController.pushViewController(viewController, animated: true)
            childCoordinatorWillStart(self)
        }
    }
}
