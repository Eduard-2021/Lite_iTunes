//
//  AppDetailWhatsNewViewController.swift
//  Lite_iTunes
//
//  Created by Eduard on 28.08.2021.
//

import UIKit

class AppDetailWhatsNewViewController: UIViewController {

    private let app: ITunesApp
    
    private var appDetailWhatsNewView: AppDetailWhatsNewView {
        return self.view as! AppDetailWhatsNewView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailWhatsNewView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
    }
    
    private func fillData() {
        appDetailWhatsNewView.titleLabel.text = "Что нового"
        appDetailWhatsNewView.versionLabel.text = "Версия " + (app.appVersion ?? "")
        appDetailWhatsNewView.descriptionLabel.text = app.releaseNotes
        appDetailWhatsNewView.versionHistoryButton.titleLabel?.text = "История версий"
        appDetailWhatsNewView.dateCreateLabel.text = ConvertDate.ConvertDateFuncForWhatsNew(releaseDate: app.currentVersionReleaseDate!)

    }
}

