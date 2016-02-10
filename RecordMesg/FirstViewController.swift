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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var player: AVAudioPlayer!
    var recorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func  viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recordButton.setImage(UIImage(named: "Mic"), forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        pointRef = self.view.center
        isRecording = false
        print("Point referemce \(pointRef)")
        
        let positionX = pointRef.x + editButton.bounds.size.width/2
        let positionY = self.view.bounds.height/4
        
        editButton.center = CGPointMake(pointRef.x + positionX, positionY)
        cancelButton.center = CGPointMake(pointRef.x - positionX, positionY)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAudioClicked(sender: AnyObject) {
        AudioManager.sharedInstance.playAudio()
    }
    
    @IBAction func stopClicked(sender: AnyObject) {
        AudioManager.sharedInstance.deleteAudio()
    }
    
   private func cancelRecording(){
    
    }

   private func EditRecording(){
    
    }
    
    private func record(){
        print("Record")
        isRecording = !isRecording
       
        if !isRecording {
             print("Its Not Recording")
            AudioManager.sharedInstance.stopAudio()
            let height = recordButton.bounds.size.height/2
            UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
                self.editButton.center = CGPointMake(self.pointRef.x + height , self.pointRef.y - height)
                self.cancelButton.center = CGPointMake(self.pointRef.x - height ,self.pointRef.y - height )
                }, completion: nil)
  
        }else {
            print("Its Recording")
            AudioManager.sharedInstance.recordAudio()
            let positionX = pointRef.x + editButton.bounds.size.width/2
            let positionY = self.view.bounds.height/4
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
                self.editButton.center = CGPointMake(self.pointRef.x + positionX, positionY)
                self.cancelButton.center = CGPointMake(self.pointRef.x - positionX, positionY)
                }, completion: nil)
        }
    }
    
    private func saveRecordTemporarily(){
    
    }
    
    private func changeIconImage(sender: UIButton , imageStr: String) {
        sender.setImage(UIImage(named: imageStr), forState: .Normal)
    }
    @IBAction func recordingButtonClicked(sender: UIButton) {
        print("recordingButtonClicked")
         record()
        
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


