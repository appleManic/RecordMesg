//
//  RecordingViewController.swift
//  RecordMesg
//
//  Created by Pawan Selokar on 2/1/16.
//  Copyright © 2016 Pawan Selokar. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var array: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RecordingViewController ViewDidLoad")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        array = ["A", "B", "C", "D", "E"]
        
        
        // Calculate the sum of the spacing between cells
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecordingViewController: UICollectionViewDataSource {
    // 1
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }

    // 2
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
}

extension RecordingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
        
        AudioManager.sharedInstance.playAudio()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("custom")
        viewController.modalPresentationStyle = UIModalPresentationStyle.PageSheet
        presentViewController(viewController, animated: true, completion: nil)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width/3, height: 150.0)
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(50, 0, 50, 0)
//    }
//    
    

    
    
//    // 1
//    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
//    self.searchResults[searchTerm][indexPath.row];
//    // 2
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35; return retval;
//    }
    
    // 3
//    - (UIEdgeInsets)collectionView:
//    (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(50, 20, 50, 20);
//    }














}
