//
//  PlayerViewController.swift
//  My Music App
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 30/11/22.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let playPauseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                print("urlString is nil")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player else {
                print("player is nil")
                return
            }
            player.volume = 0.5
            
            player.play()
            
        } catch {
            print("error occurred")
        }
        
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width - 20,
                                      height: holder.frame.size.width - 20)
        
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        songNamelabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10,
                                      width: holder.frame.size.width - 20,
                                      height: 70)
        artistNamelabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 70,
                                      width: holder.frame.size.width - 20,
                                      height: 70)
        albumNamelabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 140,
                                      width: holder.frame.size.width - 20,
                                      height: 70)
        songNamelabel.text = song.name
        artistNamelabel.text = song.artistname
        albumNamelabel.text = song.albumName
        
        holder.addSubview(songNamelabel)
        holder.addSubview(albumNamelabel)
        holder.addSubview(artistNamelabel)
        
        let backButton = UIButton()
        let nextButton = UIButton()
        
        let yPosition = albumNamelabel.frame.origin.y + 70 + 20
        let size: CGFloat = 80
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
                
        playPauseButton.addTarget(self, action: #selector(didPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didBackButton), for: .touchUpInside)

        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)

        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        
        
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: Int(holder.frame.size.height)-60,
                                            width: Int(holder.frame.size.width) - 40,
                                            height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSelectSlider(_ :)), for: .valueChanged)
        holder.addSubview(slider)
        
        
    }
    
    @objc func didPauseButton() {
        if player?.isPlaying == true {
           
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.2) { [self] in
                albumImageView.frame = CGRect(x: 30,
                                              y: 30,
                                              width: holder.frame.size.width - 60,
                                              height: holder.frame.size.width - 60)
            }
        } else {
            
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2) { [self] in
                albumImageView.frame = CGRect(x: 10,
                                              y: 10,
                                              width: holder.frame.size.width - 20,
                                              height: holder.frame.size.width - 20)
            }
        }
    }
    
    @objc func didNextButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
            
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didBackButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didSelectSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let player = player {
            player.stop()
        }
    }
}
