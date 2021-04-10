//
//  ViewController.swift
//  RGB Controller
//
//  Created by Stanislav Testov on 25.03.2021.
//

import UIKit


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
   
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var currentColorView: UIView!
    
    var viewColor: UIColor!
    var delegate: MainViewColorDelegate!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 40
        currentColorView.backgroundColor = viewColor
        
        slidersValue()
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValueForTF(for: redTF, greenTF, blueTF)
        
    }
    
    // MARK: -
    
    
    @IBAction func colorSliders(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValueForTF(for: redTF)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValueForTF(for: greenTF)
        default:
            setValue(for: blueValueLabel)
            setValueForTF(for: blueTF)
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
    
    private func setValueForTF(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                textField.text = colorValueSettings(slider: redSlider)
            case greenTF:
                textField.text = colorValueSettings(slider: greenSlider)
            default:
                textField.text = colorValueSettings(slider: blueSlider)
            }
        }
    }
    
    private func colorValueSettings(slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
        }


    private func slidersValue() {
        let components = CIColor(color: viewColor)
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let value = Float(newValue), value >= 0 && value <= 1  else {
            setValueForTF(for: redTF, greenTF, blueTF)
            return }
        
        switch textField {
        case redTF: redSlider.value = value
        case greenTF: greenSlider.value = value
        default: blueSlider.value = value
        }
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setViewColor()
    }
        
        

    func textFieldDidBeginEditing (_ textField: UITextField) {
        textField.selectAll(nil)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        toolBar.items = [button]
        
        textField.inputAccessoryView = toolBar
    }
    
    
}


