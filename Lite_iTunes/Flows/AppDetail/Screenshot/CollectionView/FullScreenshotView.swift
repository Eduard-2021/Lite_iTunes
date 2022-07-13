//
//  ScreenCollectionView.swift
//  Lite_iTunes
//
//  Created by Eduard on 31.08.2021.
//

import UIKit

class FullScreenshotView: UIView {
   
        private(set) lazy var screenshotCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            collectionView.frame = self.bounds
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .white
            return collectionView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.frame.size.width = Constants.widthScreenshot
            self.frame.size.height = Constants.heightScreenshot
            configureUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        private func configureUI() {
            self.addSubview(screenshotCollectionView)
            
            NSLayoutConstraint.activate([
                screenshotCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                screenshotCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
                screenshotCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                screenshotCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            ])
        }
    }

