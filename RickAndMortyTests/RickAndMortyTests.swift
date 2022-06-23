//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Евгений Ганусенко on 6/21/22.
//

import XCTest
@testable import RickAndMorty

class MockView: MainViewProtocol {
    func succes() {
    }

    func failure(error: RMErrors) {
    }
}

class MockNetworkService: NetworkManagerProtocol {

    var charecters: [Characters]!

    init() {}

    convenience init(charecters: [Characters]?) {
        self.init()
        self.charecters = charecters
    }

    func getCharacters(page: Int, completion: @escaping (Result<[Characters], RMErrors>) -> Void) {
        if let charecters = charecters {
            completion(.success(charecters))
        } else {
            completion(.failure(.invalidData))
        }
    }

    func getCharactersInfo(completed: @escaping (Result<[Characters], RMErrors>) -> Void) {

    }

    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {

    }
}

class MainViewPresenterTest: XCTestCase {

    var view: MockView!
    var presenter: MainViewPresenter!
    var networkManager: NetworkManagerProtocol!
    var charechters = [Characters]()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        view = nil
        networkManager = nil
        presenter = nil
    }

    func testGetSuccesCharacters() {
        let char = Characters(name: "Foo", species: "Too", gender: "Baz", episode: ["Vaz"])
        charechters.append(char)

        view = MockView()
        networkManager = MockNetworkService(charecters: [char])
        presenter = MainViewPresenter(view: view, networkManager: networkManager)

        var catchCharecters: [Characters]?

        networkManager.getCharacters(page: 1) { result in
            switch result {
            case .success(let charecters):
                catchCharecters = charecters
            case .failure(let error):
                print(error)
            }
        }

        XCTAssertNotEqual(catchCharecters?.count, 0)
        XCTAssertEqual(catchCharecters?.count, charechters.count)
    }

    func testGetFailurCharacters() {
        let char = Characters(name: "Foo", species: "Too", gender: "Baz", episode: ["Vaz"])
        charechters.append(char)

        view = MockView()
        networkManager = MockNetworkService()
        presenter = MainViewPresenter(view: view, networkManager: networkManager)

        var catchError: RMErrors?

        networkManager.getCharacters(page: 1) { result in
            switch result {
            case .success(let charecters):
               print(charecters)
            case .failure(let error):
                catchError = error
                print("\(String(describing: catchError?.rawValue))")
            }
        }

        XCTAssertNotNil(catchError)
    }
}
