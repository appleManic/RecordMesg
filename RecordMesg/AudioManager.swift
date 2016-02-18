//
//  AudioManager.swift
//  RecordMesg
//
//  Created by Pawan Selokar on 2/9/16.
//  Copyright © 2016 Pawan Selokar. All rights reserved.

import Foundation
import AVFoundation

final class AudioManager: NSObject {
    var player: AVAudioPlayer!
    var recorder: AVAudioRecorder!
    var soundFileURL: NSURL!
     var isFileExist = true
    static let sharedInstance = AudioManager()
    
    override init(){
        
//        let filemgr = NSFileManager.defaultManager()
//        let documentsURL = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
//        let fileURL = documentsURL.URLByAppendingPathComponent("sound.caf")
//        do {
//            let fileDirectory = try filemgr.attributesOfFileSystemForPath(fileURL.path!)
//            let fileSize = fileDirectory[NSFileSize]
//            if fileSize == nil {
//                isFileExist = false
//            }
//        }catch{
//            print("file is not present")
//        }
//        
//        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
//            AVEncoderBitRateKey: 16,
//            AVNumberOfChannelsKey:2,
//            AVSampleRateKey:44100.0]
//       
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        do{
//            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//        }catch{
//            print("audioSession error: \(error)")
//        }
//        
//        do{
//            try recorder = AVAudioRecorder(URL: fileURL, settings: recordSettings as! [String : AnyObject])
//        }catch {
//            print("audioSession error: \(error)")
//        }
//        
////        if let err = error {
////            print("Error \(err.localizedDescription)")
////        }else {
////            recorder?.prepareToRecord()
////        }
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
            recorder?.delegate = self
            recorder?.record()
        }
    }
    
     func stopAudio(){
        print("stop Audio")
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

extension AudioManager: AVAudioRecorderDelegate {
    //After interruption ie phone call
    func audioRecorderEndInterruption(recorder: AVAudioRecorder, withFlags flags: Int) {
        // stopAudio()
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
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        print("Audio Record Encode Error")
    }
}


extension AudioManager {

    //Check if its asking for permissions regularly
    func getPermissions(){
        //Ask for permission
        AVAudioSession.sharedInstance().requestRecordPermission { (granted: Bool) -> Void in
            if granted {
                 self.setSessionPlayAndRecord()
                 //If yes then do initial setup
                self.setUpRecorder()
            }else {
                //if no then print error
                print("Permission not granted")
            }
        }
    }
    
    func setSessionPlayAndRecord() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch  {
            print("could not set session category")
            //print(error.localizedDescription)
        }
        do {
            try session.setActive(true)
        } catch  {
            print("could not make session active")
            // print(error.localizedDescription)
        }
}
    
    func setUpRecorder(){
        // Name of file
        let currentFileName = "recording.m4a"
        print(currentFileName)
        
        //File path
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        self.soundFileURL = documentsDirectory.URLByAppendingPathComponent(currentFileName)
        
        if NSFileManager.defaultManager().fileExistsAtPath(soundFileURL.absoluteString) {
            // probably won't happen. want to do something about it?
            print("soundfile \(soundFileURL.absoluteString) exists")
        }

        // Recorder setting
        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        //Set recorder
        do {
            recorder = try AVAudioRecorder(URL: soundFileURL, settings: recordSettings)
            recorder.delegate = self
            // recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        } catch  {
            recorder = nil
            print("Recorder is not set")
        }
    }
    
    func deleteRecording(){
       let fileManager = NSFileManager.defaultManager()
        let docsDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        do {
            let files = try fileManager.contentsOfDirectoryAtPath(docsDir)
            if files[0].hasSuffix("m4a") {
                    let path = docsDir + "/" + files[0]
                    print("removing \(path)")
                    do {
                        try fileManager.removeItemAtPath(path)
                    } catch {
                        print("could not remove \(path)")
                }
            }
        }catch {
            print("No file at in the directory")
        }
    }
    
    func playRecording(){
            var url:NSURL?
            if self.recorder != nil {
                url = self.recorder.url
            } else {
                url = self.soundFileURL!
            }
            print("playing \(url)")
            
            if recorder?.recording == false {
                do{
                    try player = AVAudioPlayer(contentsOfURL: url!, fileTypeHint: "m4a")
                    player.delegate = self
                    player.prepareToPlay()
                    player.volume = 1.0
                    player.play()
                }catch {
                    print("error: \(error)")
                }
            }else {
                print("Button should be inactive")
            }
     }
    
    func stop() {
        print("stop")
        recorder?.stop()
        player?.stop()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
//            playButton.enabled = true
//            stopButton.enabled = false
//            recordButton.enabled = true
        } catch  {
            print("could not make session inactive")
        }
        //recorder = nil
    }
    
    func recording(){
        if player != nil && player.playing {
            player.stop()
        }
        if recorder == nil {
            print("recording. recorder nil")
            // recordButton.setTitle("Pause", forState:.Normal)
//            playButton.enabled = false
//            stopButton.enabled = true
             getPermissions()
            return
        }
        
        if recorder != nil && recorder.recording {
            print("pausing")
            recorder.pause()
            //  recordButton.setTitle("Continue", forState:.Normal)
            
        } else {
            print("recording")
//            recordButton.setTitle("Pause", forState:.Normal)
//            playButton.enabled = false
//            stopButton.enabled = true
              recorder.record()
//            recordWithPermission(false)
        }
    }
}

