//
//  SongsDetailViewController.swift
//  Lite_iTunes
//
//  Created by Eduard on 03.09.2021.
//

import UIKit
import MediaPlayer

@available(iOS 13.0, *)
class SongsDetailViewController: UIViewController {

    public var song: ITunesSong
    private var player: AVPlayer!
    
    
    private var songsDetailView: SongsDetailView {
        return self.view as! SongsDetailView
    }
    
    let scrollView = UIScrollView()
    let contentViewOfScrollView = UIView()
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SongsDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonPlayAndPlayer()
        self.downloadImage()
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
    
    // MARK: - Private
    
    private func configureButtonPlayAndPlayer(){
        songsDetailView.buttonPressedDelegete = self
        guard let urlString = song.previewUrl,
              let url = URL(string: urlString)
        else {return}
        player = AVPlayer(url: url)
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        songsDetailView.trackNameLabel.text = song.trackName
        songsDetailView.artistNameLabel.text = song.artistName
        songsDetailView.collectionNameLabel.text = song.collectionName
        songsDetailView.primaryGenreNameLabel.text = song.primaryGenreName
        songsDetailView.secondTrackNameLabel.text = song.trackName
        songsDetailView.trackTimeLabel.text = trackTimeString()
        songsDetailView.releaseDateLabel.text = ConvertDate.ConvertDateFuncForSongs(releaseDate: song.releaseDate!)
    }
    
    private func downloadImage() {
        CasheScreenshotService.single.getImage(urlString: song.artworkImage!, typePhoto: .songs) { [weak self] image in
            guard let self=self else {return}
            DispatchQueue.main.async { [self] in
                self.songsDetailView.albumImage.image = image
            }
        }
    }
    
    private func trackTimeString() -> String {
        let minutes = Int(round(Double(song.trackTimeMillis!)) / 60000)
        let seconds = Int(round(Float(song.trackTimeMillis! % 60000)) / 1000)
        if seconds<10 {
            return String(minutes)+":"+"0"+String(seconds)
            
        } else {
            return String(minutes)+":"+String(seconds)
        }
    }
    
}

@available(iOS 13.0, *)
extension SongsDetailViewController: ButtonPlay {
    func buttonPressed() {
        if player.timeControlStatus == .playing {
            player.pause()
            songsDetailView.previewButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            songsDetailView.previewButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
}

