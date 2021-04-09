//
//  ViewController.swift
//  RGB Controller
//
//  Created by Stanislav Testov on 25.03.2021.
//

import UIKit


class SettingsViewController: UIViewController {
   
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var currentColorView: UIView!
    
    var viewColor: UIColor!
    var delegate: MainViewColorDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 40
    
        currentColorView.backgroundColor = viewColor
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
    }
    
    // MARK: -
    
    
    @IBAction func colorSliders(_ sender: UISlider) {
        switch sender {
        case redSlider: setValue(for: redValueLabel)
        case greenSlider: setValue(for: greenValueLabel)
        default: setValue(for: blueValueLabel)
        }
        
        setViewColor()

    }
    
    @IBAction func doneButton() {
        dismiss(animated: true)
        delegate.setNewColor(for: viewColor)
    }
    
    
       
    
    private func setViewColor() {
        currentColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
         viewColor = currentColorView.backgroundColor
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = colorValueSettings(slider: redSlider)
            case greenValueLabel:
                label.text = colorValueSettings(slider: greenSlider)
            default:
                label.text = colorValueSettings(slider: blueSlider)
            }
        }
    }
    
    private func colorValueSettings(slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
        }


//    private func slidersValue() {
//        redSlider.value = viewColor
//    }
}


