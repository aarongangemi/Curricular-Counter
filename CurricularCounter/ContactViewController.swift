//
//  ContactViewController.swift
//  CurricularTracker
//
//  Created by Aaron Gangemi on 14/2/19.
//  Copyright © 2019 Aaron Gangemi. All rights reserved.
//

import UIKit
import MessageUI
class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeVC = configureMailController()
        if MFMailComposeViewController.canSendMail()
        {
            self.present(mailComposeVC, animated: true, completion: nil)
        }
        else
        {
            showMailError()
        }
    }
    
    
    func configureMailController() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["curricularcounter@gmail.com"])
        mailComposerVC.setSubject("Curricular Tracker")
        mailComposerVC.setMessageBody("Hi Curricular Counter Help", isHTML: false)
        return mailComposerVC
    }
    
    func showMailError()
    {
        let sendMailErrorAlert = UIAlertController(title: "Unable to send email", message: "Could not send email on device", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
