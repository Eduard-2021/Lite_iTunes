//
//  SearchSongsPresenter.swift
//  Lite_iTunes
//
//  Created by Eduard on 01.09.2021.
//
import UIKit

protocol SearchSongsViewInput: AnyObject {
    var searchResults: [ITunesSong] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongsViewOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelect(song: ITunesSong)
}


@available(iOS 13.0, *)
class SearchSongsPresenter {
    weak var viewInput: (UIViewController & SearchSongsViewInput)?
    private let searchService = ITunesSearchService()
    
    private func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(songs):
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = songs
            case let .failure(error):
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openSongDetails(with song: ITunesSong) {
        let songDetailViewController = SongsDetailViewController(song: song)
        viewInput?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}

@available(iOS 13.0, *)
extension SearchSongsPresenter: SearchSongsViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: false)
        requestSongs(with: query)
    }
    
    func viewDidSelect(song: ITunesSong) {
        openSongDetails(with: song)
    }
}


