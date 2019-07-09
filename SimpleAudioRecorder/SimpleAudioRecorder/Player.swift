//
//  Player.swift
//  SimpleAudioRecorder
//
//  Created by Paul Solt on 7/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

protocol PlayerDelegate: AnyObject {
    func playerDidChangeState(player: Player)
}

class Player: NSObject {
    weak var delegate: PlayerDelegate?
    
    private var audioPlayer: AVAudioPlayer!
    private var timer: Timer?
    
    // Load the piano music (.mp3)
    init(url: URL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!) {
        super.init()
        
        // get the url
//        let songURL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer.delegate = self
    }
    
    // isPlaying
    // play()
    // pause()
    // playPause()
    
    var isPlaying: Bool {
        return audioPlayer.isPlaying
    }
    
    var elapsedTime: TimeInterval {
        return audioPlayer.currentTime
    }
    
    var duration: TimeInterval {
        return audioPlayer.duration
    }
    
    func play() {
        audioPlayer.play()
        startTimer()
        notifyDelegate()
    }
    
    func pause() {
        audioPlayer.pause()
        cancelTimer()
        notifyDelegate()
    }
    
    func playPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    private func notifyDelegate() {
        delegate?.playerDidChangeState(player: self)
    }
    
    private func startTimer() {
        cancelTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: updateTimer(timer:))
    }
    
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer(timer: Timer) {
        notifyDelegate()
    }
    
    
}

extension Player: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        notifyDelegate()
    }
}
