//
//  detailViewController.swift
//  demo
//
//  Created by fun on 2020/8/14.
//

import UIKit
import AVFoundation

class detailViewController: UIViewController {
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var Song:song!
    var player : AVPlayer?
    var playerItem:AVPlayerItem?

    
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let Song = Song {
            let task = URLSession.shared.dataTask(with: Song.artworkUrl100) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }else {
                    print("data not found")
                }
            }
            task.resume()
        }else {
            print("item not found")
        }
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func play(_ sender: UIButton) {
        player?.replaceCurrentItem(with: playerItem)
        if player?.rate == 0 {
            play.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.play()
        }else{
        play.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        player?.pause()
        }

        player = AVPlayer(url: Song.previewUrl)
        player?.play()
    }
}
