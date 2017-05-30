//
//  ViewController.swift
//  Bull'sEye
//
//  Created by May Khattar on 12/11/16.
//  Copyright © 2016 MayK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var _currentvalue: Int = 0
    var _targetValue: Int = 0
    var _score: Int = 0
    var _round: Int = 0
    @IBOutlet weak var slider: UISlider! //Instance variable of slider
    @IBOutlet weak var targetLabel: UILabel! // Instance variable for target label
    @IBOutlet weak var scoreLabel: UILabel! // Instance variable for score Label
    @IBOutlet weak var roundLabel: UILabel! // Instance variable for round label
    override func viewDidLoad() {
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        super.viewDidLoad()
        startNewRound()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(){
        let difference = abs(_currentvalue-_targetValue) // abs() turns the result into absolute value meaning positive value
        var point = 100 - difference

        var title: String = ""
        if difference==0
        {
            title = "Perfect"
            point+=100 // Extra score
        }
        else if difference<5
        {
            title="You almost had it!"
            point+=50
        }
        else if difference<10
        {
            title="Pretty good!"
        }
        else
        {
            title="Not even close..."
        }
        
        _score += Int(point) // total score
        _round += 1          // total round
        let message = "You gained \(point) point"
        let alert = UIAlertController(title:title,
                                      message:message,
                                      preferredStyle:.alert)
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: { action in
                                    self.startNewRound()
                                    })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    @IBAction func sliderMoved(_ slider: UISlider) {
  
        _currentvalue=lroundf(slider.value)
    }
    func startNewRound(){
        _targetValue = 1 + Int(arc4random_uniform(100)) //To get random value use arc4random_uniform method it returns 0 to 99
        _currentvalue=50
        slider.value=Float(_currentvalue)
        updateLabels()

    }
    func updateLabels(){
    targetLabel.text = String(_targetValue)
    scoreLabel.text=String(_score)
    roundLabel.text=String(_round)
    }

    @IBAction func startOver(){
        _score=0
        _round=0
        startNewRound()
        
    }
    

}

