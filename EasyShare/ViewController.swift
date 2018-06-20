//
//  ViewController.swift
//  EasyShare
//
//  Created by Amee Thakkar on 6/20/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit
import Social
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookClick(_ sender: Any) {
        //this is deprecated in iOS 11
/*      let facebookShare = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        if let facebookShare = facebookShare{
            facebookShare.add(ImgView.image!)
            facebookShare.setInitialText(textView.text)
            
            present(facebookShare, animated: true)
        }
 */
        
        let share = [ImgView.image!, textView.text] as [Any]
        let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func twitterClick(_ sender: Any) {
    }
    @IBAction func emailClick(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let emailVC = MFMailComposeViewController()
            emailVC.mailComposeDelegate = self
            emailVC.setSubject("Cool Mansion")
            emailVC.setToRecipients(["abc@gmail.com"])
            emailVC.setMessageBody(textView.text, isHTML: true)
            
            //to attach image
            let imageData = UIImagePNGRepresentation(ImgView.image!)
            emailVC.addAttachmentData(imageData!, mimeType: "image/png", fileName: "picture.png")
            
            present(emailVC, animated: true)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .saved{
           //if message was saved, do this
        }
        else if result == .sent{
            //if message was sent, do this
        }
        controller.dismiss(animated: true, completion: nil)
    }
    @IBAction func smsClick(_ sender: Any) {
        if MFMessageComposeViewController.canSendText(){
            let smsVC = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            smsVC.body = textView.text
            smsVC.recipients = ["123456789","987654321"]
            
            let imgData = UIImagePNGRepresentation(ImgView.image!)
            smsVC.addAttachmentData(imgData!, typeIdentifier: "identifier", filename: "picture.png")
            
            present(smsVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if result == .sent{
            print("Message was sent successfully")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    @IBAction func othersClick(_ sender: Any) {
        
        let share = UIActivityViewController(activityItems: [ImgView.image!,textView.text], applicationActivities: [])
        
        //for iPad Activity View Controller crashes
        share.popoverPresentationController?.barButtonItem = shareBtn
        present(share,animated: true)
    }
}

