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
    
    var numberOfActions: Int = 5
    var shouldShowTitle = true
    var shouldShowMessage = true
    var shouldShowCancelButton = true
    var shouldShowImages = true
    var shouldTapBackgroundToDismiss = true
    var shouldDragViewToDismiss = true
    
    @IBOutlet weak var collectionButton: UIButton!
    
    @IBOutlet weak var numberOfActionsLabel: UILabel!
    
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
        let title = shouldShowTitle ? "Action Sheet" : nil
        let message = shouldShowMessage ? "Select an action" : nil
        let table = DMActionController(title: title,
                                       message: message,
                                       preferredStyle: .table)
        let disabled = addActions(to: table)
        table.tapBackgroundToDismiss = shouldTapBackgroundToDismiss
        table.canDragToDismiss = shouldDragViewToDismiss
        present(table, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            disabled?.isEnabled = true
        }
    }
    
    @IBAction func didPressCollection() {
        let title = shouldShowTitle ? "Action Sheet" : nil
        let message = shouldShowMessage ? "Select an action" : nil
        let collection = DMActionController(title: title,
                                            message: message,
                                            preferredStyle: .collection)
        let disabled = addActions(to: collection)
        collection.tapBackgroundToDismiss = shouldTapBackgroundToDismiss
        collection.canDragToDismiss = shouldDragViewToDismiss
        present(collection, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            disabled?.isEnabled = true
        }
    }
    
    @discardableResult
    private func addActions(to sheet: DMActionController) -> DMAction? {
        var disabled: DMAction?
        for i in 1...numberOfActions {
            var ix = i
            while ix > 5 { ix -= 5 }
            let image = shouldShowImages ? UIImage(named: "icon-\(ix)", in: Bundle(for: ViewController.self), compatibleWith: nil) : nil
            let action = DMAction(image: image, title: "Action \(i)", style: .default)
            sheet.addAction(action)
            if i == 2 {
                action.isEnabled = false
                disabled = action
            }
        }
        if shouldShowCancelButton {
            sheet.addAction(DMAction(title: "Cancel", style: .cancel))
        }
        return disabled
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ap = DMActionController.appearance()
        ap.backgroundColor = .green
        ap.cornerRadius = 0
        ap.dragViewWidth = 100
        ap.dragViewCornerRadius = 2
        ap.setActionImageTint(.yellow, forStyle: .default)
        ap.setActionImageTint(.orange, forStyle: .cancel)
        ap.setActionTextAttributes([.foregroundColor: UIColor.white], forStyle: .default)
        ap.setActionTextAttributes([.foregroundColor: UIColor.orange], forStyle: .cancel)
    }
    
}

