//
//  FirstViewController.swift
//  RecordMesg
//
//  Created by Pawan Selokar on 2/1/16.
//  Copyright © 2016 Pawan Selokar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    private var pointRef: CGPoint!
    private var isRecording: Bool!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func  viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    private func beforeClickedAnimation(button: UIButton){
        let frame = self.view.bounds
        _ = CGPointMake(frame.size.width + button.bounds.size.width, -(frame.size.height/4))
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
            }, completion: nil)
    }
    
    private func afterClickedAnimation(button: UIButton){
        
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
            let height = recordButton.bounds.size.height/2
            UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
                self.editButton.center = CGPointMake(self.pointRef.x + height , self.pointRef.y - height)
                self.cancelButton.center = CGPointMake(self.pointRef.x - height ,self.pointRef.y - height )
                }, completion: nil)
  
        }else {
            print("Its Recording")
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

