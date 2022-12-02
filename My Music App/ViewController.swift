//
//  ViewController.swift
//  My Music App
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 30/11/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSongs()
        setupTableView()
    }
    
    func configureSongs() {
        songs.append(Song(name: "Esla meni",
                          albumName: "123",
                          artistname: "Xamdam Sobirov",
                          imageName: "cover3",
                          trackName: "song3"))
        
        songs.append(Song(name: "Lala",
                          albumName: "456",
                          artistname: "Trio Mandela",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "Calm Down",
                          albumName: "678",
                          artistname: "Rema",
                          imageName: "cover1",
                          trackName: "song1"))
        
        songs.append(Song(name: "Esla meni",
                          albumName: "123",
                          artistname: "Xamdam Sobirov",
                          imageName: "cover3",
                          trackName: "song3"))
        
        songs.append(Song(name: "Lala",
                          albumName: "456",
                          artistname: "Trio Mandela",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "Calm Down",
                          albumName: "678",
                          artistname: "Rema",
                          imageName: "cover1",
                          trackName: "song1"))
        
        songs.append(Song(name: "Esla meni",
                          albumName: "123",
                          artistname: "Xamdam Sobirov",
                          imageName: "cover3",
                          trackName: "song3"))
        
        songs.append(Song(name: "Lala",
                          albumName: "456",
                          artistname: "Trio Mandela",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "Calm Down",
                          albumName: "678",
                          artistname: "Rema",
                          imageName: "cover1",
                          trackName: "song1"))
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
    // My music app yasadim endi commit qilmoqchiman men buni lekin qanday qilishni bilmayman.
}

