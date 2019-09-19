//
//  ViewController.swift
//  Example
//
//  Created by Dominic Miller on 9/2/19.
//  Copyright © 2019 Dominic Miller (dominicmdev@gmail.com)
//

import UIKit

import DMActionController

class ViewController: UIViewController {
    
    var actionImages: [UIImage] = []
    
    var numberOfActions: Int = 5
    var shouldShowTitle = true
    var shouldShowMessage = true
    var shouldShowCancelButton = true
    var shouldShowImages = true
    var shouldTapBackgroundToDismiss = true
    var shouldDragViewToDismiss = true
    
    @IBOutlet weak var collectionButton: UIButton!
    @IBOutlet weak var numberOfActionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...5 {
            let image = UIImage(
                named: "icon-\(i)",
                in: Bundle(for: ViewController.self),
                compatibleWith: nil
                )!
                .withRenderingMode(.alwaysTemplate)
            actionImages.append(image)
        }
    }
    
    @IBAction func didChangeNumberOfActions(_ sender: UISlider) {
        numberOfActions = Int(sender.value.rounded())
        numberOfActionsLabel.text = "\(numberOfActions)"
    }
    
    @IBAction func didChangeCancel(_ sender: UISwitch) {
        shouldShowCancelButton = sender.isOn
    }
    
    @IBAction func didChangeImages(_ sender: UISwitch) {
        shouldShowImages = sender.isOn
        collectionButton.isEnabled = sender.isOn
    }
    
    @IBAction func didChangeTitle(_ sender: UISwitch) {
        shouldShowTitle = sender.isOn
    }
    
    @IBAction func didChangeMessage(_ sender: UISwitch) {
        shouldShowMessage = sender.isOn
    }
    
    @IBAction func didChangeBackground(_ sender: UISwitch) {
        shouldTapBackgroundToDismiss = sender.isOn
    }
    
    @IBAction func didChangeDrag(_ sender: UISwitch) {
        shouldDragViewToDismiss = sender.isOn
    }
    
    @IBAction func didPressTable() {
        presentActionController(style: .table)
    }
    
    @IBAction func didPressCollection() {
        presentActionController(style: .collection)
    }
    
    private func presentActionController(style: DMActionController.Style) {
        let title = shouldShowTitle ? "Action Sheet" : nil
        let message = shouldShowMessage ? "Select an action" : nil
        let sheet = DMActionController(title: title, message: message, preferredStyle: style)
        sheet.preferences.tapBackgroundToDismiss = shouldTapBackgroundToDismiss
        sheet.preferences.dragToDismiss = shouldDragViewToDismiss
        addActions(to: sheet)
        present(sheet, animated: true)
    }
    
    private func addActions(to sheet: DMActionController) {
        for i in 1...numberOfActions {
            var im = i - 1
            while im > 4 { im -= 5 }
            let image = shouldShowImages ? actionImages[im] : nil
            sheet.addAction(DMAction(image: image, title: "Action \(i)", style: .default))
        }
        if shouldShowCancelButton {
            sheet.addAction(DMAction(title: "Cancel", style: .cancel))
        }
    }
    
}
