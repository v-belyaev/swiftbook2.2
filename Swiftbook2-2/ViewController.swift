//
//  ViewController.swift
//  Swiftbook2-2
//
//  Created by Владимир Беляев on 06.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var targetView: UIView! {
        didSet {
            targetView.layer.cornerRadius = 10
        }
    }
    @IBOutlet var guessView: UIView! {
        didSet {
            guessView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var guessRedLabel: UILabel!
    @IBOutlet var guessGreenLabel: UILabel!
    @IBOutlet var guessBlueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var checkButton: UIButton! {
        didSet {
            checkButton.layer.cornerRadius = 8
        }
    }
    
    // MARK: Private properties
    private var redColor = CGFloat.random(in: 0...1)
    private var greenColor = CGFloat.random(in: 0...1)
    private var blueColor = CGFloat.random(in: 0...1)
    
    // MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRandomValuesForSliders()
        initialSetupUI()
    }
    
    // MARK: IB Actions
    @IBAction func moveRedSlider(_ sender: UISlider) {
        guessRedLabel.text = "\(Int(sender.value))"
        changeBackgroundColor()
    }
    
    @IBAction func moveGreenSlider(_ sender: UISlider) {
        guessGreenLabel.text = "\(Int(sender.value))"
        changeBackgroundColor()
    }
    
    @IBAction func moveBlueSlider(_ sender: UISlider) {
        guessBlueLabel.text = "\(Int(sender.value))"
        changeBackgroundColor()
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        let alert = createAlert()
        self.present(alert, animated: true) {
            self.setRandomValuesForSliders()
            self.setRandomTargetColors()
            self.initialSetupUI()
        }
    }
    
    // MARK: Private methods
    private func initialSetupUI() {
        targetView.backgroundColor = UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1)
        guessView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255,
            green: CGFloat(greenSlider.value) / 255,
            blue: CGFloat(blueSlider.value) / 255,
            alpha: 1)
        
        guessRedLabel.text = "\(Int(redSlider.value))"
        guessGreenLabel.text = "\(Int(greenSlider.value))"
        guessBlueLabel.text = "\(Int(blueSlider.value))"
    }
    
    private func changeBackgroundColor() {
        guessView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255,
            green: CGFloat(greenSlider.value) / 255,
            blue: CGFloat(blueSlider.value) / 255,
            alpha: 1)
    }
    
    private func setRandomValuesForSliders() {
        redSlider.value = Float.random(in: 0...255)
        greenSlider.value = Float.random(in: 0...255)
        blueSlider.value = Float.random(in: 0...255)
    }
    
    private func computeScore() -> Int {
        let redDifference = redSlider.value / 255 - Float(redColor)
        let greenDifference = greenSlider.value / 255 - Float(greenColor)
        let blueDifference = blueSlider.value / 255 - Float(blueColor)
        
        let difference = sqrt(redDifference * redDifference + greenDifference * greenDifference + blueDifference * blueDifference)
        return Int((1.0 - difference) * 100.0 + 0.5)
    }
    
    private func createAlert() -> UIAlertController {
        let score = computeScore()
        let alert = UIAlertController(title: "Alert", message: "Your score: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    private func setRandomTargetColors() {
        redColor = CGFloat.random(in: 0...1)
        greenColor = CGFloat.random(in: 0...1)
        blueColor = CGFloat.random(in: 0...1)
    }

}

