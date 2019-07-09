//
//  AudioViewController.swift
//  SimpleAudioRecorder
//
//  Created by Paul Solt on 7/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {
    
    lazy private var player = Player()
    
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        playButton.titleLabel.title // TODO: fix button title clipping without stackview
        player.delegate = self
    }

    private func updateViews() {
//        playButton.isSelected = true
        playButton.setTitle(player.isPlaying ? "Pause" : "Play", for: .normal)
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        player.playPause()
    }
}

extension AudioViewController: PlayerDelegate {
    func playerDidChangeState(player: Player) {
        updateViews()
    }
}
