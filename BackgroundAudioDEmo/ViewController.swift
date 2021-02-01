//
//  ViewController.swift
//  BackgroundAudioDEmo
//
//  Created by Knoxpo MacBook Pro on 01/02/21.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    let videoPlaayer = URL(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")!
    lazy var player: AVPlayer = {
        return AVPlayer(url: videoPlaayer)
        
    }()
    
    lazy var playerviewcontroller: AVPlayerViewController = {
        let vc = AVPlayerViewController()
        vc.player = self.player
        vc.showsPlaybackControls = true
        return vc
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func showVedio(_ sender: Any)
    {
        present(playerviewcontroller, animated: true) {
            
            self.player.play()
        }
    
    
    }
    
   func disconnectplyer()
   {
    
    playerviewcontroller.player = nil
    
   }
    
    
    func reconnectPlyer()
    {
        
        playerviewcontroller.player = player
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

