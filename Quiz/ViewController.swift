//
//  ViewController.swift
//  Quiz
//
//  Created by Ariel Scott-Dicker on 2017-11-05.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var currentQuestionLabel: UILabel!
	@IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
	@IBOutlet var nextQuestionLabel: UILabel!
	@IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
	@IBOutlet var answerLabel: UILabel!
	
	let questions: [String] = [
		"What is 7+7",
		"What is the capital of Vermont?",
		"What is cognac made from?"
	]
	
	let answers: [String] = [
		"14",
		"Montpelier",
		"Grapes"
	]
	
	var currentQuestionIndex: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		currentQuestionLabel.text = questions[currentQuestionIndex]
		updateOffScreenLabel()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set the label's initial alpha
		nextQuestionLabel.alpha = 0
	}
	
	func updateOffScreenLabel() {
		let screenWidth = view.frame.width
		nextQuestionLabelCenterXConstraint.constant = -screenWidth
	}
	
	@IBAction func showNextQuestion(_ sender: UIButton) {
		currentQuestionIndex += 1
		if currentQuestionIndex == questions.count {
			currentQuestionIndex = 0
		}
		
		let question: String = questions[currentQuestionIndex]
		nextQuestionLabel.text = question
		answerLabel.text = "???"
		
		animateLabelTransitions()
	}
	
	@IBAction func showAnswer(_ sender: UIButton) {
		let answer: String = answers[currentQuestionIndex]
		answerLabel.text = answer
	}
	
	func animateLabelTransitions() {
		// Force any outstanding layout changes to occur
		view.layoutIfNeeded()
		
		// Animate the alpha and the center X constraints
		let screenWidth = view.frame.width
		nextQuestionLabelCenterXConstraint.constant = 0
		currentQuestionLabelCenterXConstraint.constant += screenWidth
		
		UIView.animate(withDuration: 0.5,
					   delay: 0,
					   options: [],
					   animations: {
						self.currentQuestionLabel.alpha = 0
						self.nextQuestionLabel.alpha = 1
						self.view.layoutSubviews()
		},
					   completion: { _ in
						swap(&self.currentQuestionLabel,
							 &self.nextQuestionLabel)
						swap(&self.currentQuestionLabelCenterXConstraint,
							 &self.nextQuestionLabelCenterXConstraint)
						
						self.updateOffScreenLabel()
		})		
	}
}

