//
//  ViewController.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 10/11/2020.
//

import UIKit
import GameKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logoButton: UIButton!
    @IBOutlet weak var centerLabel: UILabel!
    
    var recordData: String!
    var recordDataAsInt: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 || UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            centerLabel.font = centerLabel.font.withSize(50)
        }
        
        authenticateUser()
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
        if recordData != nil {
            recordDataAsInt = Int(recordData)
        }
        
        logoButton.addTarget(self, action: #selector(didTapWatermark), for: .touchUpInside)
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        startButton.pulse()
    }
    
    @objc func didTapWatermark(sender: AnyObject) {
        guard let instagram = URL(string: "https://www.instagram.com/turizam_srbije") else { return }
        UIApplication.shared.open(instagram)
    }
    
    private func authenticateUser() {
        
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = { vc, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

    @IBAction func showLeaderboards(_ sender: Any) {
        
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        vc.leaderboardIdentifier = "MilosPetrusic.SerbiaQuiz.Scores"
        present(vc, animated: true, completion: nil)
        saveHighScore(number: recordDataAsInt ?? 0)
    }
    
    func saveHighScore(number: Int) {
        
        if GKLocalPlayer.local.isAuthenticated {
            let score = GKScore(leaderboardIdentifier: "MilosPetrusic.SerbiaQuiz.Scores")
            score.value = Int64(number)
            GKScore.report([score]) { (error) in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
            }
        }
    }
    
}

extension StartViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
}

