//
//  ScreenshotCollectionViewCell.swift
//  Lite_iTunes
//
//  Created by Eduard on 31.08.2021.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
        
        // MARK: - Subviews
        
        private(set) lazy var screenImageView: UIImageView = {
            let screen = UIImageView()
            screen.translatesAutoresizingMaskIntoConstraints = false
            return screen
        }()
        
        // MARK: - Init
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.configureUI()
        }
        override func prepareForReuse() {
            super.prepareForReuse()
            screenImageView.image = nil
        }
        
        // MARK: - Methods
        
        func configure(screen: UIImage) {
            self.configureUI()
            screenImageView.image = screen
        }
        
        // MARK: - UI
        
        private func configureUI() {
            self.contentView.addSubview(self.screenImageView)
            NSLayoutConstraint.activate([
                self.screenImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.screenImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                self.screenImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                self.screenImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
                ])
        }
}


