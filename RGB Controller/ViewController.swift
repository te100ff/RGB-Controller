//
//  ViewController.swift
//  RGB Controller
//
//  Created by Stanislav Testov on 25.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IB Outlets
    @IBOutlet weak var redNameLabel: UILabel!
    @IBOutlet weak var greenNameLabel: UILabel!
    @IBOutlet weak var blueNameLabel: UILabel!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var currentColorView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Superview setup
        view.backgroundColor = .lightGray
        
        // MARK: Color view setup
        currentColorView.layer.cornerRadius = 40
        
        // MARK: Labels setup
        redNameLabel.text = "Red:"
        redNameLabel.isHighlighted = true
        redNameLabel.highlightedTextColor = .red
        
        greenNameLabel.text = "Green:"
        greenNameLabel.isHighlighted = true
        greenNameLabel.highlightedTextColor = .green
        
        blueNameLabel.text = "Blue:"
        blueNameLabel.isHighlighted = true
        blueNameLabel.highlightedTextColor = .blue
        
        // MARK: Sliders setup
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        redSlider.minimumTrackTintColor = .red
        redSlider.value = 0
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        greenSlider.minimumTrackTintColor = .green
        greenSlider.value = 0
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        blueSlider.minimumTrackTintColor = .blue
        blueSlider.value = 0
        
        // MARK: Setup methods
        colorValueSettings()
        colorSettings()
        
    }
    
    //MARK: IB Actions
    @IBAction func redSetup() {
        colorSettings()
        colorValueSettings()
    }
    
    @IBAction func greenSetup() {
        colorSettings()
        colorValueSettings()
    }
    
    @IBAction func blueSetup() {
        colorSettings()
        colorValueSettings()
    }
    
    // MARK: Private methods
    private func colorSettings() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        currentColorView.backgroundColor = UIColor.init(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
   private func colorValueSettings() {
    redValueLabel.text = String(format: "%.2f", redSlider.value)
    greenValueLabel.text = String(format: "%.2f", greenSlider.value)
    blueValueLabel.text = String(format: "%.2f", blueSlider.value)
   }


}

