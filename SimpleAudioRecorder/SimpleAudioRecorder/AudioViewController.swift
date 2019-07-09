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
    lazy private var recorder = Recorder()
    
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        playButton.titleLabel.title // TODO: fix button title clipping without stackview
        player.delegate = self
        recorder.delegate = self
        
        
        timeElapsedLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeElapsedLabel.font.pointSize, weight: .regular)
        timeRemainingLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeElapsedLabel.font.pointSize, weight: .regular)
        
    }

    private func updateViews() {
//        playButton.isSelected = true
        playButton.setTitle(player.isPlaying ? "Pause" : "Play", for: .normal)
        
        timeElapsedLabel.text = timeFormatter.string(from: player.elapsedTime)
        
        slider.minimumValue = 0
        slider.maximumValue = Float(player.duration)
        slider.value = Float(player.elapsedTime)
        
        recordButton.setTitle(recorder.isRecording ? "Stop Recording" : "Record", for: .normal)
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        player.playPause()
    }
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        recorder.toggleRecording()
    }
}

extension AudioViewController: PlayerDelegate {

    func playerDidChangeState(player: Player) {
        updateViews()
        
        // update the player with the recording
        
        if !recorder.isRecording,
            let recordedURL = recorder.fileURL {
            
            // player with new file
            self.player = Player(url: recordedURL)
            player.delegate = self
        }
        
    }
}

extension AudioViewController: RecorderDelegate {
    func recorderDidChangeState(recorder: Recorder) {
        updateViews()
    }
}
