//
//  ScreenshotViewController.swift
//  Lite_iTunes
//
//  Created by Eduard on 31.08.2021.
//

import UIKit

class FullScreenshotViewController: UIViewController {
    private let app: ITunesApp
    private let numberItem: Int
   
    private var screenCollectionView: FullScreenshotView {
        return self.view as! FullScreenshotView
    }
    
    init(app: ITunesApp, numberItem: Int) {
        self.app = app
        self.numberItem = numberItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = FullScreenshotView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screenCollectionView.screenshotCollectionView.delegate = self
        screenCollectionView.screenshotCollectionView.dataSource = self
        screenCollectionView.screenshotCollectionView.register(
            ScreenshotCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.reuseIdentifierForScreenshotCollectionViewCell)
        screenCollectionView.self.backgroundColor = .white
    }
    
}

extension FullScreenshotViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifierForScreenshotCollectionViewCell, for: indexPath) as? ScreenshotCollectionViewCell else
        {return UICollectionViewCell()}
        downloadImage(cell: cell, url: app.screenshotUrls[indexPath.row])
        return cell
    }
    
    private func downloadImage(cell:ScreenshotCollectionViewCell, url: String) {
        CasheScreenshotService.single.getImage(urlString: url, typePhoto: .screenshot) { [weak self] image in
            DispatchQueue.main.async {
                               cell.configure(screen: image!)
            }
        }
    }
    
}

extension FullScreenshotViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenCollectionView.self.frame.size.width-20, height: screenCollectionView.self.frame.size.height-20)
    }
}

