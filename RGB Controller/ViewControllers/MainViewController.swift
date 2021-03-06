//
//  MainViewController.swift
//  RGB Controller
//
//  Created by Stanislav Testov on 08.04.2021.
//

import UIKit

protocol MainViewColorDelegate {
    func setNewColor(for main: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.viewColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: MainViewColorDelegate {
    func setNewColor(for main: UIColor) {
        view.backgroundColor = main
    }
    
}
