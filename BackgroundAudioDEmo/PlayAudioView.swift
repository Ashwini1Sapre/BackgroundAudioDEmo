//
//  PlayAudioView.swift
//  BackgroundAudioDEmo
//
//  Created by Knoxpo MacBook Pro on 01/02/21.
//

import UIKit

import AVFoundation


class PlayAudioView: UIViewController {
    
    @IBOutlet var SongLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    lazy var player: AVQueuePlayer = self.MakePlayer()
    
    private lazy var songs: [AVPlayerItem] = {
        
        let songName = ["FeelinGood", "IronBacon", "WhatYouWant"]
        
        return songName.map {
            let url = Bundle.main.url(forResource: $0, withExtension: "mp3")!
            return AVPlayerItem(url: url)
            
        }
        
    }()
    
    
    
    override func viewDidLoad() {
        do {
            try (AVAudioSession.sharedInstance().setCategory)(
            
                AVAudioSession.Category.playAndRecord,
            mode: .default,
                options: [])
            
        }
        catch{
            print("\(Error.self)")
        }
        
        
        
        
        player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 200), queue: DispatchQueue.main) { [weak self] time in
            
            
            guard let self = self else { return }
            let timestring = String(format: "%02.2f", CMTimeGetSeconds(time))
            
            if UIApplication.shared.applicationState == .active {
                
                self.timeLabel.text = timestring
                
                
                
            }
            else
            {
                print("BackGround : \(timestring)")
                
            }
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    
    
  
    
    
    
    private func MakePlayer() -> AVQueuePlayer {
        
        let player = AVQueuePlayer(items:  songs)
        player.actionAtItemEnd = .advance
        player.addObserver(self, forKeyPath: "currentItem", options: [.new,.initial], context: nil)
        
       return player
        
    }
    
    
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?)
    
    
  override  func observeValue(forKeyPath keypath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        
        if keypath ==  "currentItem",
        let player = object as? AVPlayer,
        
            let currentPlayer = player.currentItem?.asset as? AVURLAsset {
        
                SongLabel.text = currentPlayer.url.lastPathComponent
            }
        
        
    }
    
    
    @IBAction  func plaYBUtton( _ sender: UIButton) {
        sender.isSelected = !sender.isSelected
          
            
            if sender.isSelected{
            player.play()
            
            }
            else
            {
                player.pause()
            }
            
   
      
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    

