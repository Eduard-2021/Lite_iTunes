//
//  AppDetailWhatsNewView.swift
//  Lite_iTunes
//
//  Created by Eduard on 28.08.2021.
//

import UIKit

class AppDetailWhatsNewView: UIView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var versionHistoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("История версий", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private(set) lazy var dateCreateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = Constants.fontDescriptionLabel
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        self.addSubview(descriptionLabel)
        self.addSubview(dateCreateLabel)
        self.addSubview(versionHistoryButton)
        self.addSubview(versionLabel)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 160),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            versionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            versionLabel.widthAnchor.constraint(equalToConstant: 120),
            versionLabel.heightAnchor.constraint(equalToConstant: 25),
            
            versionHistoryButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            versionHistoryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            versionHistoryButton.widthAnchor.constraint(equalToConstant: 150),
            versionHistoryButton.heightAnchor.constraint(equalToConstant: 40),
            
            dateCreateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateCreateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            dateCreateLabel.widthAnchor.constraint(equalToConstant: 120),
            dateCreateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constants.widthDescriptionLabel),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let line = CAShapeLayer()
        let bezieLine = UIBezierPath()
        bezieLine.move(to: CGPoint(x:30, y:2))
        bezieLine.addLine(to: CGPoint(x:frame.maxX-30, y:2))
        
        line.path = bezieLine.cgPath
        line.strokeColor = UIColor(white: 0.8, alpha: 1).cgColor
        line.lineWidth = 1
        layer.addSublayer(line)
    }
}

 


