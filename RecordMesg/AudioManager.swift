//
//  AudioManager.swift
//  RecordMesg
//
//  Created by Pawan Selokar on 2/9/16.
//  Copyright © 2016 Pawan Selokar. All rights reserved.
//

import Foundation
import AVFoundation

final class AudioManager: NSObject {
    var player: AVAudioPlayer!
    var recorder: AVAudioRecorder!
    static let sharedInstance = AudioManager()
    
    override init(){
        let filemgr = NSFileManager.defaultManager()
        let documentsURL = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("sound.caf")
        
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey:2,
            AVSampleRateKey:44100.0]
        var error: NSError!
        
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }catch{
            print("audioSession error: \(error)")
        }
        
        do{
            try recorder = AVAudioRecorder(URL: fileURL, settings: recordSettings as! [String : AnyObject])
        }catch{
            print("audioSession error: \(error)")
        }
        
        if let err = error {
            print("Error \(err.localizedDescription)")
        }else {
            recorder?.prepareToRecord()
        }
    }
    
    func deleteAudio(){
        let filemgr = NSFileManager.defaultManager()
        let documentsURL = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("sound.caf")
        let filePath = fileURL.path
        if filemgr.fileExistsAtPath(filePath!) {
            print("File exits")
            do{
                try filemgr.removeItemAtURL(fileURL)
                print("File exits \(filePath!)")
            }catch{
                print("audioSession error: \(error)")
            }
        }else {
            print("No file is there")
        }
    }
    
     func recordAudio(){
        if recorder?.recording == false {
            recorder?.record()
        }
    }
    
     func stopAudio(){
        
        if recorder?.recording == true {
            recorder?.stop()
        } else {
            player?.stop()
        }
    }
    
     func playAudio(){
        print("Play Audio")
        if recorder?.recording == false {
            var error: NSError?
            do{
                try player = AVAudioPlayer(contentsOfURL: (recorder?.url)!, fileTypeHint: "caf")
                player.delegate = self
            }catch {
                print("error: \(error)")
            }
            if let err = error {
                print("audioPlayer error: \(err.localizedDescription)")
            } else {
                player?.play()
            }
        }
    }
}

extension AudioManager: AVAudioPlayerDelegate{
    @objc func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying")
        //        recordButton.enabled = true
        //        stopButton.enabled = false
    }
    
    @objc func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }


}