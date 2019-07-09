//
//  Player.swift
//  SimpleAudioRecorder
//
//  Created by Paul Solt on 7/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation




class Player: NSObject {
    
    private var audioPlayer: AVAudioPlayer!
    
    // Load the piano music (.mp3)
    override init() {
        super.init()
        
        // get the url
        let songURL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: songURL)
    }
    
    // isPlaying
    // play()
    // pause()
    // playPause()
    
    var isPlaying: Bool {
        return audioPlayer.isPlaying
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func pause() {
        audioPlayer.pause()
    }
    
    func playPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
}
