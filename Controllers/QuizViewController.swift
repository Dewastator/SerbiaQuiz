//
//  QuizViewController.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 10/11/2020.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var questionLabelBackground: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageBackground: UIView!
    
    let allQuestions = QuestionBank()
    var selectedAnswer = 0
    var questionNumber = 0
    var score = 0
    var recordData: String!
    var answersInRow = 1
    
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var questionImage: UIImageView!
    
    var timer: Timer?
    var seconds = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 || UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            optionA.titleLabel?.font = optionA.titleLabel?.font.withSize(16)
            optionB.titleLabel?.font = optionB.titleLabel?.font.withSize(16)
            optionC.titleLabel?.font = optionC.titleLabel?.font.withSize(16)
            optionD.titleLabel?.font = optionD.titleLabel?.font.withSize(16)
        }
        
        if UIDevice.current.screenType == .iPhones_X_XS {
            optionA.titleLabel?.font = optionA.titleLabel?.font.withSize(18)
            optionB.titleLabel?.font = optionB.titleLabel?.font.withSize(18)
            optionC.titleLabel?.font = optionC.titleLabel?.font.withSize(18)
            optionD.titleLabel?.font = optionD.titleLabel?.font.withSize(18)
        }
        
        // Disable multitouch on buttons.
        UIButton.appearance().isExclusiveTouch = true
        
        questionLabelBackground.layer.cornerRadius = 20
        imageBackground.layer.cornerRadius = 20
        optionA.layer.cornerRadius = 10
        optionB.layer.cornerRadius = 10
        optionC.layer.cornerRadius = 10
        optionD.layer.cornerRadius = 10
        questionImage.layer.cornerRadius = 10
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
        }
        
        updateQuestion()
        updateUI()
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
        
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
    
    @IBAction func answerPressed(_ sender: UIButton) {
        
        if sender.tag == selectedAnswer {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            sender.backgroundColor = .green
            sender.pulsate()
            UIView.animate(withDuration: 1.0) {
                sender.backgroundColor = .white
            }
            score += 10
            answersInRow += 1
            print(answersInRow)
            if answersInRow == 6 {
                ProgressHUD.showAdded("5 секунди!")
            }
            
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            sender.backgroundColor = .red
            sender.shake()
            UIView.animate(withDuration: 1.0) {
                sender.backgroundColor = .white
            }
            score -= 3
            answersInRow = 1
        }
        optionA.isEnabled = false
        optionB.isEnabled = false
        optionC.isEnabled = false
        optionD.isEnabled = false
        questionNumber += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            updateQuestion()
            optionA.isEnabled = true
            optionB.isEnabled = true
            optionC.isEnabled = true
            optionD.isEnabled = true
        }
    }
    
    @objc func updateTimer() {
        if seconds > 0 && seconds <= 120 {
            seconds -= 1
            if answersInRow % 6 == 0 {
                seconds += 5
                answersInRow = 1
            }
            if seconds <= 5 {
                timerLabel.textColor = .red
            }
            updateTimeLabel()
        } else {
            alertPopup()
            timer?.invalidate()
            highScoreRecord()
        }
    }
    
    func updateTimeLabel() {
        if timerLabel != nil {
            let min = (seconds/60) % 60
            let sec = seconds % 60
            
            let min_p = String(format: "%2d", min)
            let sec_p = String(format: "%02d", sec)
            
            timerLabel.text = ("\(min_p):\(sec_p)")
        }
    }
    
    func updateUI() {
        scoreLabel.text = "\(score)"
        if allQuestions.list[questionNumber].picture == nil {
            imageBackground.isHidden = true
        } else {
            imageBackground.isHidden = false
            UIView.transition(with: questionImage, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
            UIView.transition(with: imageBackground, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    func updateQuestion() {
        if questionNumber <= allQuestions.list.count - 1 {
            questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControl.State.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControl.State.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControl.State.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControl.State.normal)
            questionImage.image = allQuestions.list[questionNumber].picture
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            updateUI()
            
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You finished all questions, do you wanna start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
                
            }
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func alertPopup() {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController {
            
            self.present(vc, animated: true, completion: nil)
            
            vc.yourScoreLabel?.text = "\(score)"
        }
        
        
    }
    
    func startOver() {
        
        seconds = 120
        score = 0
        questionNumber = 0
        updateQuestion()
        updateUI()
        
    }
    
    func highScoreRecord() {
        
        if recordData == nil {
            
            let savedScore = scoreLabel.text
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(savedScore, forKey: "Record")
            
        } else {
            
            let score: Int? = Int(scoreLabel.text!)
            let record: Int? = Int(recordData)
            
            if score! > record! {
                
                let savedScore = scoreLabel.text
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedScore, forKey: "Record")
                
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        sender.pulsate()
        
    }
}
