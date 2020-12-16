//
//  Question.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 10/11/2020.
//

import UIKit

class Question {
    
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let picture: UIImage?
    let correctAnswer: Int
    
    init(questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, image: UIImage?, answer: Int) {
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        picture = image
        correctAnswer = answer
    }
    
}
