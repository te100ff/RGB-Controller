//
//  ViewController.swift
//  RGB Controller
//
//  Created by Stanislav Testov on 25.03.2021.
//

import UIKit


class ViewController: UIViewController {
   
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var currentColorView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 40
    
        colorValueSettings()
        colorSettings()
    }
    
    // MARK: - 

    @IBAction func allSliders() {
        colorSettings()
        colorValueSettings()
    }
    
    private func colorSettings() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        currentColorView.backgroundColor = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1)
    }
    
    private func colorValueSettings() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }


}

