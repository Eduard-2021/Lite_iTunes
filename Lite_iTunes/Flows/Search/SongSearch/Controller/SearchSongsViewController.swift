//
//  SearchViewController.swift
//  Lite_iTunes
//
//  Created by Eduard on 01.09.2021.
//

import  UIKit

final class SearchSongsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: SearchSongsViewOutput
    private let imageDownloader = ImageDownloader()
    
    private var searchView: SearchSongsView {
        return self.view as! SearchSongsView
    }
    
    private let searchService = ITunesSearchService()
    
    var searchResults = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    init(presenter: SearchSongsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchSongsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(SongsCell.self, forCellReuseIdentifier: Constants.reuseIdentifierForSearchSongsCell)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
}

//MARK: - UITableViewDataSource
extension SearchSongsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierForSearchSongsCell, for: indexPath)
        guard let cell = dequeuedCell as? SongsCell else {
            return dequeuedCell
        }
        let song = self.searchResults[indexPath.row]
        let cellModel = SongsCellModelFactory.cellModel(from: song)
        cell.configure(with: cellModel)
        downloadImage(songUrl: song.artworkImage!, cell: cell)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchSongsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = searchResults[indexPath.row]
        presenter.viewDidSelect(song: song)
    }
}

//MARK: - UISearchBarDelegate
extension SearchSongsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        presenter.viewDidSearch(with: query)
    }
}

extension SearchSongsViewController: SearchSongsViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}

//MARK: - DownloadImage
extension SearchSongsViewController {
    private func downloadImage(songUrl: String, cell: SongsCell) {
//        guard let url = app.iconUrl else { return }
        
        imageDownloader.getImage(fromUrl: songUrl) { [weak self] (image, error) in
            guard let self = self else { return }
            
            if error == nil {
                DispatchQueue.main.async {
                    cell.albumImage.image = image
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

