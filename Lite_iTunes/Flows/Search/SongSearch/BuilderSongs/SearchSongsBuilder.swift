//
//  SearchSongsBuilder.swift
//  Lite_iTunes
//
//  Created by Eduard on 01.09.2021.
//

import UIKit

@available(iOS 13.0, *)
class SearchSongsBuilder {
    static func build() -> (UIViewController & SearchSongsViewInput) {
        let presenter = SearchSongsPresenter()
        let viewController = SearchSongsViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
