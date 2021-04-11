//
//  SettingsViewController.swift
//  RGB Controller
//
//  Created by Stanislav Testov on 25.03.2021.
//

import UIKit


class SettingsViewController: UIViewController {
    // MARK: - IB Outlets
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
    
    // MARK: - Public properties
    var viewColor: UIColor!
    var delegate: MainViewColorDelegate!
    
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 40
        currentColorView.backgroundColor = viewColor
        
        startingSlidersValue()
        setLabelsValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setTextFieldsValue(for: redTF, greenTF, blueTF)
    }
    
    // MARK: - IB Actions
    @IBAction func colorSliders(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setLabelsValue(for: redValueLabel)
            setTextFieldsValue(for: redTF)
        case greenSlider:
            setLabelsValue(for: greenValueLabel)
            setTextFieldsValue(for: greenTF)
        default:
            setLabelsValue(for: blueValueLabel)
            setTextFieldsValue(for: blueTF)
        }
        
        setViewColor()
    }
    
    @IBAction func doneButton() {
        dismiss(animated: true)
        delegate.setNewColor(for: viewColor)
    }
    
    // MARK: - Private methods
    private func startingSlidersValue() {
        let components = CIColor(color: viewColor)
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
    }
    
    private func setViewColor() {
        currentColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        viewColor = currentColorView.backgroundColor
    }
    
    private func setLabelsValue(for labels: UILabel...) {
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
    
    private func setTextFieldsValue(for textFields: UITextField...) {
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
    
}



// MARK: - Textfields (keyboard) setup
extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        textField.selectAll(nil)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        toolBar.items = [space, button]
        
        textField.inputAccessoryView = toolBar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let value = Float(newValue), value >= 0 && value <= 1  else {
            showAlert(
                title: "Information",
                message: "Enter value from 0.0 to 1.0",
                textField: textField)
            return }
        
        
        switch textField {
        case redTF:
            redSlider.value = value
            setLabelsValue(for: redValueLabel)
            setTextFieldsValue(for: textField)
        case greenTF:
            greenSlider.value = value
            setLabelsValue(for: greenValueLabel)
            setTextFieldsValue(for: textField)
        default:
            blueSlider.value = value
            setLabelsValue(for: blueValueLabel)
            setTextFieldsValue(for: textField)
        }
        
        setViewColor()
    }
    
}



// MARK: - Alert setup
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.setTextFieldsValue(for: textField)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}


