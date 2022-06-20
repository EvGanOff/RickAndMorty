//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by Евгений Ганусенко on 6/14/22.
//

import UIKit

class CharactersListViewController: RMDataLoadingVC {

    enum Section {
        case main
    }

    //MARK: - Properties -

    var presenter: MainViewPresenterProtocol?

    var collectionView: UICollectionView!
    var collectionDataSource: UICollectionViewDiffableDataSource<Section, Characters>!
    var hasMoreCharacters = true
    var isLoadingMoreCharacters = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rick and Morty"
        configureViewController()
        configureCollectionCell()

    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let nextButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = nextButton
    }

    private func configureCollectionCell() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeCulumnFlowLayout(in: view))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.userID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }

    @objc
    func addButtonTapped() {
        guard hasMoreCharacters, !isLoadingMoreCharacters else { return }
    }
}

extension CharactersListViewController: MainViewProtocol {

    func succes() {
        collectionView.reloadData()

    }

    func failure(error: RMErrors) {
        print(error.rawValue)
    }
}

extension CharactersListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let cherecters = presenter?.characters

        presenter?.selectPersonAt(index: indexPath.row)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeigth = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        scrollView.showsVerticalScrollIndicator = false
        if offsetY > contentHeigth - height {
            guard hasMoreCharacters, !isLoadingMoreCharacters else { return }
            DispatchQueue.main.async {
                self.presenter?.getMoreCherecters()
                self.collectionView.reloadData()
                self.view.bringSubviewToFront(self.collectionView)
            }
        }
    }
}

// MARK: - CollectionViewDataSource -

extension CharactersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.characters?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.userID, for: indexPath) as! CharacterCell
        let char = self.presenter?.characters?[indexPath.row]
        cell.set(characterName: char!)

        return cell
    }
}


