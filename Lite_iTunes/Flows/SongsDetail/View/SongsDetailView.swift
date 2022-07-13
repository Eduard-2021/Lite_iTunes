
//  SongsDetailView.swift
//  Lite_iTunes
//
//  Created by Eduard on 03.09.2021.
//

import UIKit

protocol ButtonPlay {
    func buttonPressed()
}

@available(iOS 13.0, *)
class SongsDetailView: UIView {

        // MARK: - Subviews
        
    var buttonPressedDelegete: ButtonPlay!
    let throbber = UIActivityIndicatorView(style: .gray)
    
    private(set) lazy var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 200, height: 200)
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var previewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.contentHorizontalAlignment = .left
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private(set) lazy var previewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "ПРЕДПРОСМОТР"
        label.font = UIFont.systemFont(ofSize: 10.0)
        return label
    }()
    
    private(set) lazy var emptyRedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemRed
        label.layer.cornerRadius = 10.0
        label.layer.masksToBounds = true
        label.text = ""
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private(set) lazy var secondTrackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var trackTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var primaryGenreNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        return label
    }()
    
        // MARK: - Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.configureUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.configureUI()
        }
    
        //MARK: Aktion
    @objc func buttonPlayPressed(){
        buttonPressedDelegete.buttonPressed()
    }
        
        // MARK: - UI
        
        private func configureUI() {
            previewButton.addTarget(self, action: #selector(buttonPlayPressed), for: .touchUpInside)
            self.backgroundColor = .white
            addSubviews()
        }
        
        private func addSubviews() {
            self.addSubview(albumImage)
            
            self.throbber.translatesAutoresizingMaskIntoConstraints = false
            self.albumImage.addSubview(self.throbber)

            self.addSubview(trackNameLabel)
            self.addSubview(artistNameLabel)
            self.addSubview(collectionNameLabel)
            self.addSubview(previewLabel)
            self.addSubview(emptyRedLabel)
            emptyRedLabel.addSubview(previewButton)
            emptyRedLabel.addSubview(secondTrackNameLabel)
            emptyRedLabel.addSubview(trackTimeLabel)
            self.addSubview(releaseDateLabel)
            self.addSubview(primaryGenreNameLabel)
            
            NSLayoutConstraint.activate([
                albumImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                albumImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
                albumImage.heightAnchor.constraint(equalToConstant: 200.0),
                albumImage.widthAnchor.constraint(equalToConstant: 200.0),
                throbber.centerXAnchor.constraint(equalTo: albumImage.centerXAnchor),
                throbber.centerYAnchor.constraint(equalTo: albumImage.centerYAnchor),
                trackNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 20),
                trackNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                trackNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
                trackNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
                artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 5),
                artistNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                artistNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
                artistNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
                collectionNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 5),
                collectionNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                collectionNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
                collectionNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
                previewLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 25),
                previewLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
                emptyRedLabel.topAnchor.constraint(equalTo: previewLabel.bottomAnchor,constant: 5),
                emptyRedLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                emptyRedLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                emptyRedLabel.heightAnchor.constraint(equalToConstant: 30),
                previewButton.centerYAnchor.constraint(equalTo: emptyRedLabel.centerYAnchor),
                previewButton.leftAnchor.constraint(equalTo: emptyRedLabel.leftAnchor, constant: 10),
                previewButton.heightAnchor.constraint(equalToConstant: 24),
                previewButton.widthAnchor.constraint(equalToConstant: 24),
                secondTrackNameLabel.centerYAnchor.constraint(equalTo: emptyRedLabel.centerYAnchor),
                secondTrackNameLabel.leftAnchor.constraint(equalTo: previewButton.rightAnchor, constant: 7),
                trackTimeLabel.centerYAnchor.constraint(equalTo: emptyRedLabel.centerYAnchor),
                trackTimeLabel.rightAnchor.constraint(equalTo: emptyRedLabel.rightAnchor, constant: -10),
                releaseDateLabel.topAnchor.constraint(equalTo: emptyRedLabel.bottomAnchor, constant: 20),
                releaseDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                primaryGenreNameLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor),
                primaryGenreNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                ])
        }
    }

