//
//  AppDetailScreenView.swift
//  Lite_iTunes
//
//  Created by Eduard on 29.08.2021.
//
import UIKit

class AppDetailScreenshotView: UIView {
   
        private(set) lazy var screenshotCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = Constants.sizeScreenshot
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
        
        override func draw(_ rect: CGRect) {
            let line = CAShapeLayer()
            let bezieLine = UIBezierPath()
            bezieLine.move(to: CGPoint(x:30, y:0))
            bezieLine.addLine(to: CGPoint(x:frame.maxX-30, y:0))
            
            line.path = bezieLine.cgPath
            line.strokeColor = UIColor(white: 0.8, alpha: 1).cgColor
            line.lineWidth = 1
            layer.addSublayer(line)
        }
    }

