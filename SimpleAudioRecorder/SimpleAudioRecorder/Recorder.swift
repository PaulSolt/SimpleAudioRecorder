//
//  Recorder.swift
//  SimpleAudioRecorder
//
//  Created by Paul Solt on 7/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

protocol RecorderDelegate {
    func recorderDidChangeState(recorder: Recorder)
}

class Recorder: NSObject {
    
    private var audioRecorder: AVAudioRecorder?
    var delegate: RecorderDelegate?
    var fileURL: URL?
    
    var isRecording: Bool {
        return audioRecorder?.isRecording ?? false
    }
    
    override init() {
        super.init()
    }
    
    func record() {
        // save a file in the documents directory
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("doc: \(documentDirectory)")

        // filename.caf

        let name = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])
        fileURL = documentDirectory.appendingPathComponent(name).appendingPathExtension("caf")
        
        // 48khz = cd quality
        // 44.1khz
        
        let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!
        
        audioRecorder = try! AVAudioRecorder(url: fileURL!, format: format)
        audioRecorder?.delegate = self
        
        audioRecorder?.record()
        // start the recording
        notifyDelegate()
    }
    
    func stop() {
        audioRecorder?.stop()
        audioRecorder = nil
        notifyDelegate()
    }
    
    private func notifyDelegate() {
        delegate?.recorderDidChangeState(recorder: self)
    }
    
    func toggleRecording() {
        if isRecording {
            stop()
        } else {
            record()
        }
    }
}

extension Recorder: AVAudioRecorderDelegate {
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Error: \(error)")
        notifyDelegate()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        notifyDelegate()
    }
    
    
}
