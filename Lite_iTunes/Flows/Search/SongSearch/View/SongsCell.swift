//
//  SongsCell.swift
//  Lite_iTunes
//
//  Created by Eduard on 01.09.2021.
//

import UIKit

final class SongsCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 40, height: 40)
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
//        self.albumImage.image = cellModel.image
        self.trackNameLabel.text = cellModel.trackName
        self.artistNameLabel.text = cellModel.artistName
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        self.albumImage.image = nil
        [self.trackNameLabel, self.artistNameLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addAlbumImage()
        self.addTrackNameLabel()
        self.adArtistNameLabel()
    }
    
    private func addAlbumImage() {
        self.contentView.addSubview(self.albumImage)
        NSLayoutConstraint.activate([
            self.albumImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.albumImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.albumImage.widthAnchor.constraint(equalToConstant: 40),
            self.albumImage.heightAnchor.constraint(equalToConstant: 40),
            ])
    }
    
    private func addTrackNameLabel() {
        self.contentView.addSubview(self.trackNameLabel)
        NSLayoutConstraint.activate([
            self.trackNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 11.0),
            self.trackNameLabel.leftAnchor.constraint(equalTo: self.albumImage.rightAnchor, constant: 8.0),
            self.trackNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15.0)
            ])
    }
    
    private func adArtistNameLabel() {
        self.contentView.addSubview(self.artistNameLabel)
        NSLayoutConstraint.activate([
            self.artistNameLabel.topAnchor.constraint(equalTo: self.trackNameLabel.bottomAnchor, constant: 4.0),
            self.artistNameLabel.leftAnchor.constraint(equalTo: self.albumImage.rightAnchor, constant: 8.0),
            self.artistNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15.0)
            ])
    }
}

