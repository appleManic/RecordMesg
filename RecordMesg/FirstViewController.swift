//
//  FirstViewController.swift
//  RecordMesg
//
//  Created by Pawan Selokar on 2/1/16.
//  Copyright © 2016 Pawan Selokar. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    private var pointRef: CGPoint!
    private var isRecording: Bool!
    private var isPlaying: Bool!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var player: AVAudioPlayer!
    var recorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("FirstViewController ViewDidLoad")
      let bool = AudioManager.sharedInstance.isFileExist
        isPlaying = false
        recordButton.enabled = true
        playButton.enabled = false
        print("Bool is \(bool)")
    }
    
    override func  viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // recordButton.setImage(UIImage(named: "Mic"), forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("FirstViewController ViewDidAppear")
        pointRef = playButton.center //self.view.center
        isRecording = false
        
        let positionX = pointRef.x + editButton.bounds.size.width/2
        let positionY = self.view.bounds.height/2
        
        editButton.center = CGPointMake(pointRef.x + positionX, positionY)
        cancelButton.center = CGPointMake(pointRef.x - positionX, positionY)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAudioClicked(sender: AnyObject) {
        playButton.enabled = true
        isPlaying = !isPlaying
        if isPlaying! {
            playButton.backgroundColor = UIColor.greenColor()
            AudioManager.sharedInstance.playAudio()
            outwardAnimation()
        }else {
            playButton.backgroundColor = UIColor.redColor()
            AudioManager.sharedInstance.stopAudio()
            inwardAnimation()
        }
    }
    
    @IBAction func stopClicked(sender: AnyObject) {
        AudioManager.sharedInstance.deleteAudio()
    }
    
    @IBAction func recordingButtonClicked(sender: UIButton) {
        print("recordingButtonClicked")
         record()
    }
    
    @IBAction func cancelButtonClicked(sender: UIButton) {
        cancelRecording()
        playButton.enabled = false
    }
    
    @IBAction func editButtonClicked(sender: UIButton) {
        EditRecording()
    }
}

extension FirstViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying")
//        recordButton.enabled = true
//        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }
}

private extension FirstViewController {
    
    func inwardAnimation(){
        let height = recordButton.bounds.size.height/2
        UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
            self.editButton.center = CGPointMake(self.pointRef.x + height , self.pointRef.y - height)
            self.cancelButton.center = CGPointMake(self.pointRef.x - height ,self.pointRef.y - height )
            // print("edit: \(self.editButton.center) \t cancesel: \(self.cancelButton.center)")
            }, completion: nil)
    }
    
    func outwardAnimation(){
        let positionX = pointRef.x + editButton.bounds.size.width/2
        let positionY = self.view.bounds.height/2
        UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
            self.editButton.center = CGPointMake(self.pointRef.x + positionX, positionY)
            self.cancelButton.center = CGPointMake(self.pointRef.x - positionX, positionY)
            // print("edit: \(self.editButton.center) \t cancesel: \(self.cancelButton.center)")
            }, completion: nil)
    }
    
    func saveRecordTemporarily(){
        
    }

    func changeIconImage(sender: UIButton , imageStr: String) {
        sender.setImage(UIImage(named: imageStr), forState: .Normal)
    }
    
    func cancelRecording(){
        outwardAnimation()
    }
    
    func EditRecording(){
        outwardAnimation()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("recordingView")
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func record(){
        print("Record")
        recordButton.enabled = true
        isRecording = !isRecording
        if !isRecording {
            print("Its Not Recording")
            playButton.enabled = true
            recordButton.backgroundColor = UIColor.redColor()
            AudioManager.sharedInstance.stopAudio()
        }else {
            print("Its Recording")
            playButton.enabled = false
            recordButton.backgroundColor = UIColor.greenColor()
            AudioManager.sharedInstance.recordAudio()
        }
    }
}


