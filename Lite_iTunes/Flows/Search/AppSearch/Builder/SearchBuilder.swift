//
//  SearchBuilder.swift
//  Lite_iTunes
//
//  Created by Eduard on 26.08.2021.
//

import UIKit

class SearchAppBuilder {
    static func build() -> (UIViewController & SearchAppViewInput) {
        let presenter = SearchAppPresenter()
        let viewController = SearchAppViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}


