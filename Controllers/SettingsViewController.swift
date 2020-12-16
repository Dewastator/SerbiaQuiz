//
//  SettingsViewController.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 6.12.20..
//

import UIKit
import StoreKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.cornerRadius = 10
        
    }
    @IBAction func questionProposalPressed(_ sender: Any) {
        showProposalMailComposer()
    }
    
    @IBAction func rulesButtonPressed(_ sender: Any) {
        textView.isHidden = !textView.isHidden
        UIView.transition(with: textView, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    @IBAction func reviewButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Feedback time!",
                                      message: "Да ли вам се допада Српски квиз?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да, одлична је!",
                                      style: .default,
                                      handler: { [weak self]_ in
                                        guard let scene = self?.view.window?.windowScene else {
                                            print("No scene")
                                            return
                                        }
                                        if #available(iOS 14.0, *) {
                                            SKStoreReviewController.requestReview(in: scene)
                                        } else {
                                            SKStoreReviewController.requestReview()
                                        }
                                      }))
        alert.addAction(UIAlertAction(title: "Не допада ми се.",
                                      style: .default,
                                      handler: { [weak self]_ in
                                        self?.showMailComposer()
                                      }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    func showMailComposer() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["petrusicmilos94@gmail.com"])
            mail.setSubject("Здраво!")
            
            present(mail, animated: true)
        } else {
            print("Error")
        }
    }
    
    
    func showProposalMailComposer() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["petrusicmilos94@gmail.com"])
            mail.setSubject("Предлог питања!")
            mail.mailComposeDelegate = self
            present(mail, animated: true)
        } else {
            print("Error")
        }
    }
    @IBAction func contactUsPressed(_ sender: Any) {
        showMailComposer()
    }
    
    @IBAction func privacyPolicyButtonPressed(_ sender: Any) {
        if let url = URL(string: "https://sites.google.com/view/srpskikviz/home") {
            UIApplication.shared.open(url)
        }
    }
    
}
