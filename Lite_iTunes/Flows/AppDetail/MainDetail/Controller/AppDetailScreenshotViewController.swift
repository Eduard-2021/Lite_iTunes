//
//  AppDetailScreenViewController.swift
//  Lite_iTunes
//
//  Created by Eduard on 29.08.2021.
//


import UIKit

class AppDetailScreenshotViewController: UIViewController {

    private let app: ITunesApp
    private var collectionView: UICollectionView?
    
    
    private var appDetailScreenshotView: AppDetailScreenshotView {
        return self.view as! AppDetailScreenshotView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailScreenshotView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDetailScreenshotView.screenshotCollectionView.delegate = self
        appDetailScreenshotView.screenshotCollectionView.dataSource = self
        appDetailScreenshotView.screenshotCollectionView.register(
            AppDetailScreenshotCell.self,
            forCellWithReuseIdentifier: Constants.reuseIdentifierForScreenshotCell)
    }
    
    
    private func downloadImage(cell:AppDetailScreenshotCell, url: String) {
        CasheScreenshotService.single.getImage(urlString: url, typePhoto: .screenshot) { [weak self] image in
            DispatchQueue.main.async {
                               cell.configure(screen: image!)
            }
        }
    }
}

extension AppDetailScreenshotViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifierForScreenshotCell, for: indexPath) as? AppDetailScreenshotCell else
        {return UICollectionViewCell()}
        downloadImage(cell: cell, url: app.screenshotUrls[indexPath.row])
        return cell
    }
}

extension AppDetailScreenshotViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        appDetailScreenshotView.screenshotCollectionView.deselectItem(at: indexPath, animated: true)
        let screenshotViewController = FullScreenshotViewController(app: app, numberItem: indexPath.item)
        navigationController?.pushViewController(screenshotViewController, animated: true)
    }
}

