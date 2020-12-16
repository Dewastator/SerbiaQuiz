//
//  ScoreViewController.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 10/11/2020.
//

import UIKit
import GoogleMobileAds

class ScoreViewController: UIViewController {
    
    struct Constants {
        static let quizAdId = "ca-app-pub-6004625736419558/5136759534"
//        static let testAdId = "ca-app-pub-3940256099942544/4411468910"
    }
    
    private var interstitialAD: GADInterstitial?

    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interstitialAD = createAd()
        
        restartButton.layer.cornerRadius = 10
        restartButton.clipsToBounds = true
        homeButton.layer.cornerRadius = 10
        homeButton.clipsToBounds = true
        yourScoreLabel.layer.cornerRadius = 10
        highScoreLabel.layer.cornerRadius = 10
        yourScoreLabel.layer.masksToBounds = true
        highScoreLabel.layer.masksToBounds = true
        logoImage.layer.cornerRadius = 10

    }
    
    override func viewWillAppear(_ animated: Bool) {
       
       let userDefaults = Foundation.UserDefaults.standard
       let value = userDefaults.string(forKey: "Record")
       
       if (value == nil) {
           
           highScoreLabel.text = "0"
           
       } else {
           
           highScoreLabel.text = value
           
       }
   }

    @IBAction func restartButtonPressed(_ sender: UIButton) {
        
        showAd()
        
        let restartAlert = UIAlertController(title: "Рестарт", message: "Да ли сте сигурни да желите да поновите квиз?", preferredStyle: .alert)
        
        restartAlert.addAction(UIAlertAction(title: "Рестарт", style: .default, handler: { (UIAlertAction) in self.restartPopup()
        }))
        
        present(restartAlert, animated: true, completion: nil)
        
    }
    
    func restartPopup() {
        
        if let restartVC = storyboard?.instantiateViewController(identifier: "QuizView") as? QuizViewController {
            
            self.present(restartVC, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        showAd()
    }
    
    private func createAd() -> GADInterstitial {
        let ad = GADInterstitial(adUnitID: Constants.quizAdId)
        ad.delegate = self
        ad.load(GADRequest())
        return ad
    }
    
    private func showAd() {
        let x = Int.random(in: 0..<10)
        if x % 2 == 0 {
            if interstitialAD?.isReady == true {
                interstitialAD?.present(fromRootViewController: self)
            }
        }
    }
    
}

extension ScoreViewController: GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        interstitialAD = createAd()
    }
}
