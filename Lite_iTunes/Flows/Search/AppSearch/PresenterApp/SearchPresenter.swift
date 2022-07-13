//  SearchPresenter.swift
//  Lite_iTunes
//
//  Created by Eduard on 26.08.2021.
//

import UIKit

protocol SearchAppViewInput: AnyObject {
    var searchResults: [ITunesApp] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchAppViewOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelect(app: ITunesApp)
}

class SearchAppPresenter {
    weak var viewInput: (UIViewController & SearchAppViewInput)?
    private let searchService = ITunesSearchService()
    
    private func requestApp(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(apps):
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            case let .failure(error):
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let appDetailViewController = AppDetailViewController(app: app, sizeReleaseNotes: CalculatingHeightOfText().findHeightForText(text: app.releaseNotes!, havingWidth: Constants.widthDescriptionLabel, andFont: Constants.fontDescriptionLabel))
        viewInput?.navigationController?.pushViewController(appDetailViewController, animated: true)
    }
    
}

extension SearchAppPresenter: SearchAppViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: false)
        requestApp(with: query)
    }
    
    func viewDidSelect(app: ITunesApp) {
        openAppDetails(with: app)
    }
    
    
}


